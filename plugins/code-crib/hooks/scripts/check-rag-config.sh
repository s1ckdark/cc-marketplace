#!/bin/bash
# Check RAG configuration and return settings
# Falls back gracefully if CLAUDE_PLUGIN_ROOT is not set

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Possible config locations (in priority order)
CONFIG_LOCATIONS=(
    "${CLAUDE_PLUGIN_ROOT}/code-crib.local.md"
    "${PLUGIN_ROOT}/code-crib.local.md"
    "${PWD}/.claude/code-crib.local.md"
    "${HOME}/.claude/code-crib.local.md"
)

CONFIG_FILE=""

# Find first existing config file
for loc in "${CONFIG_LOCATIONS[@]}"; do
    # Skip if variable expansion resulted in empty or invalid path
    [[ -z "$loc" || "$loc" == "/code-crib.local.md" ]] && continue

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
# Look for "enabled: true" or "enabled: false" under auto_rag section
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
' "$CONFIG_FILE")

# Default to false if not found or unparseable
if [[ "$RAG_ENABLED" == "true" ]]; then
    echo "{\"rag_enabled\": true, \"config_file\": \"$CONFIG_FILE\"}"
else
    echo "{\"rag_enabled\": false, \"config_file\": \"$CONFIG_FILE\"}"
fi
