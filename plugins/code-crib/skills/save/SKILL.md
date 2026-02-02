---
name: save
description: Save your work to the knowledge stash. Use when the user wants to save, store, or document their work session.
---

# Save / Stash

Stash your work session as a doc in the knowledge base.

## Usage

```
/code-crib:stash                    # (stash command)
/code-crib:stash --type bugfix --tags "auth,session"
```

## Parameters

- `type`: Work type (bugfix, feature, refactor, analysis) - auto-detected if not provided
- `title`: Document title - auto-generated if not provided
- `tags`: Comma-separated tags for categorization
- `namespace`: Project namespace for organization

## Instructions

1. **Analyze the conversation** to understand what was accomplished
2. **Classify work type** if not provided:
   - `bugfix`: Bug fixes, error resolutions
   - `feature`: New functionality added
   - `refactor`: Code restructuring
   - `analysis`: Code exploration, architecture review

3. **Generate structured document** with:
   - Problem description
   - Solution implemented
   - Files modified
   - Key learnings

4. **Save to Pinecone** using upsert-records:
   ```
   Index: code-crib
   Namespace: project name or provided
   Record fields:
   - id: namespace-timestamp-hash
   - content: Full document text
   - type, title, project, date, tags, files
   ```

5. **Confirm to user** with document title, type, tags, and record ID

## Auto-detection Hints

- "error", "bug", "fix" → `bugfix`
- "add", "implement", "new feature" → `feature`
- "refactor", "clean", "restructure" → `refactor`
- "how", "why", "explain" → `analysis`
