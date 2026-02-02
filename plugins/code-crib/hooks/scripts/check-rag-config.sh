#!/bin/bash
# Check RAG configuration and return settings
# Falls back gracefully if paths don't exist

# Safely get script directory (avoid cd errors)
SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
    SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}" 2>/dev/null)"
    if [[ -n "$SCRIPT_DIR" ]] && [[ -d "$SCRIPT_DIR" ]]; then
        SCRIPT_DIR="$(cd "$SCRIPT_DIR" 2>/dev/null && pwd)"
    fi
fi

# Calculate plugin root from script location
PLUGIN_ROOT=""
if [[ -n "$SCRIPT_DIR" ]]; then
    PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." 2>/dev/null && pwd)"
fi

# Possible config locations (in priority order)
# Only add paths that are valid (non-empty and not just "/code-crib.local.md")
CONFIG_LOCATIONS=()

[[ -n "$CLAUDE_PLUGIN_ROOT" ]] && CONFIG_LOCATIONS+=("${CLAUDE_PLUGIN_ROOT}/code-crib.local.md")
[[ -n "$PLUGIN_ROOT" ]] && CONFIG_LOCATIONS+=("${PLUGIN_ROOT}/code-crib.local.md")
[[ -n "$PWD" ]] && CONFIG_LOCATIONS+=("${PWD}/.claude/code-crib.local.md")
[[ -n "$HOME" ]] && CONFIG_LOCATIONS+=("${HOME}/.claude/code-crib.local.md")

CONFIG_FILE=""

# Find first existing config file
for loc in "${CONFIG_LOCATIONS[@]}"; do
    if [[ -f "$loc" ]]; then
        CONFIG_FILE="$loc"
        break
    fi
done

# If no config found, RAG is disabled by default
if [[ -z "$CONFIG_FILE" ]]; then
    echo '{"rag_enabled": false, "reason": "no_config_found"}'
    exit 0
fi

# Parse YAML frontmatter for auto_rag.enabled
RAG_ENABLED=$(awk '
    /^---$/ { in_frontmatter = !in_frontmatter; next }
    in_frontmatter && /^auto_rag:/ { in_auto_rag = 1; next }
    in_frontmatter && in_auto_rag && /^[a-z_]+:/ && !/^  / { in_auto_rag = 0 }
    in_frontmatter && in_auto_rag && /enabled:/ {
        gsub(/.*enabled:[ ]*/, "")
        gsub(/[ #].*/, "")
        print tolower($0)
        exit
    }
' "$CONFIG_FILE" 2>/dev/null)

# Default to false if not found or unparseable
if [[ "$RAG_ENABLED" == "true" ]]; then
    echo "{\"rag_enabled\": true, \"config_file\": \"$CONFIG_FILE\"}"
else
    echo "{\"rag_enabled\": false, \"config_file\": \"$CONFIG_FILE\"}"
fi
