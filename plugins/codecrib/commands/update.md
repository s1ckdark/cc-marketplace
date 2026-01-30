---
name: update
description: Update codecrib plugin to the latest version from GitHub
arguments: []
---

# Update CodeCrib

Update the plugin to the latest version from GitHub.

## Instructions

### Step 1: Get Plugin Directory

Find the codecrib plugin installation path:
- Check if running from marketplace install or local development
- Use `${CLAUDE_PLUGIN_ROOT}` if available

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
✅ codecrib is already up to date!
```

**If updates available:**
Show list of new commits.

### Step 4: Pull Updates

```bash
git pull origin main
```

### Step 5: Report Result

**Success:**
```
✅ codecrib updated successfully!

Changes:
- <commit 1>
- <commit 2>
- ...

Restart Claude Code to apply changes.
```

**Failure:**
```
❌ Update failed

Error: <error message>

Try manual update:
  cd <plugin-directory>
  git pull origin main
```

## Example Usage

```
/update
```

## Notes

- Local changes will be preserved (git stash if needed)
- `codecrib.local.md` is git-ignored, settings are safe
- Restart Claude Code after update to load new features
