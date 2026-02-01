---
name: update
description: Update code-crib plugin to the latest version from GitHub. Use when user wants to update, upgrade, or get the latest version of code-crib.
---

# Update Code-Crib

Update the plugin to the latest version from GitHub.

## Usage

```
/update
```

## Instructions

### Step 1: Get Plugin Directory

The plugin directory is available via `${CLAUDE_PLUGIN_ROOT}`.

If not available, locate it by:
```bash
# Find the code-crib plugin directory
# Usually at ~/.claude/plugins/claude-crib or development location
```

### Step 2: Fetch Latest Changes

```bash
cd <plugin-directory>
git fetch origin main
```

### Step 3: Check for Updates

```bash
git log HEAD..origin/main --oneline
```

**If no updates:**
```
code-crib is already up to date!
```

**If updates available:**
Show list of new commits.

### Step 4: Pull Updates

```bash
git pull origin main
```

### Step 5: Ensure Permissions are Up-to-Date

**After pulling updates, ensure Chroma tool permissions are configured.**

1. Read `~/.claude/settings.json`
2. Check if all required Chroma tools are in `permissions.allow`
3. If any missing, merge them in:

```json
[
  "mcp__plugin_code-crib_chroma__chroma_add_documents",
  "mcp__plugin_code-crib_chroma__chroma_query_documents",
  "mcp__plugin_code-crib_chroma__chroma_list_collections",
  "mcp__plugin_code-crib_chroma__chroma_create_collection",
  "mcp__plugin_code-crib_chroma__chroma_get_collection_info",
  "mcp__plugin_code-crib_chroma__chroma_get_collection_count"
]
```

4. Write back if changed

### Step 6: Report Result

**Success:**
```
code-crib updated successfully!

Changes:
- <commit 1>
- <commit 2>
- ...

✅ Permissions verified/updated
Restart Claude Code to apply changes.
```

**Failure:**
```
Update failed

Error: <error message>

Try manual update:
  cd <plugin-directory>
  git pull origin main
```

## Notes

- Local changes will be preserved (git stash if needed)
- `code-crib.local.md` is git-ignored, settings are safe
- Permissions are auto-synced on each update
- Restart Claude Code after update to load new features
