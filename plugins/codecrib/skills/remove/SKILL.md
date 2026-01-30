---
name: remove
description: Remove docs from your stash - delete unwanted knowledge. Use when user wants to remove, delete, dump, or clean up their stashed documents.
---

# Remove Command

Delete docs from your knowledge stash.

## Usage

```
codecrib:remove
```

## Instructions

### Option 1: Remove by ID

1. Fetch the document from vector DB to confirm existence
2. Show document title and metadata
3. Ask for confirmation (unless --confirm)
4. Delete from vector DB

### Option 2: Remove by Search

1. Search for matching documents
2. Display list with numbers
3. Let user select which to remove
4. Delete selected documents

### Option 3: Bulk Cleanup

1. Find all docs matching criteria (e.g., older than X days)
2. Display count and sample titles
3. Require explicit confirmation
4. Delete in batches

## Arguments

- `id`: Document ID to remove
- `query`: Search query to find docs to remove (interactive selection)
- `namespace`: Only remove from this namespace
- `older-than`: Remove docs older than X days
- `confirm`: Skip confirmation prompt

## Safety Features

- Always shows what will be deleted before acting
- Requires confirmation unless `--confirm` is passed
- Logs deleted document IDs for recovery reference

## Examples

```bash
# Remove specific document
codecrib:remove --id "myproject-2024-01-15-fix123"

# Find and remove interactively
codecrib:remove --query "deprecated feature"

# Clean old docs (careful!)
codecrib:remove --older-than 180 --confirm

# Remove from specific namespace
codecrib:remove --namespace old-project --older-than 90
```

## Recovery Note

Deleted docs are gone from vector DB. If you have local `.rag-docs/` files, you can re-index them with `codecrib:rack`.
