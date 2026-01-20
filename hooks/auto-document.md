---
name: auto-document
description: Automatically prompts to save work documentation at session end
event: Stop
---

# Auto-Document Hook

Automatically suggests saving work to RAG when a session ends with significant work completed.

## Trigger Conditions

This hook activates on the `Stop` event and should prompt documentation when:

1. **Code changes were made**: Files were edited, created, or deleted
2. **Substantial conversation**: Session involved problem-solving or implementation
3. **Auto-save enabled**: Plugin setting `auto_save` is true

## Behavior

When triggered, present the user with:

```
---
Work session detected with the following activity:
- Files modified: {{count}}
- Main topics: {{detected-topics}}

Would you like to save this as documentation?
[Y] Save with auto-detected settings
[C] Customize before saving
[N] Skip
---
```

### If user selects [Y]:
1. Invoke documenter agent automatically
2. Auto-detect work type and metadata
3. Save to default namespace
4. Confirm with summary

### If user selects [C]:
1. Ask for work type preference
2. Ask for custom title
3. Ask for additional tags
4. Then proceed with save

### If user selects [N]:
1. Skip documentation
2. Continue with session end

## Detection Heuristics

### Work Type Detection
- Contains "fix", "bug", "error" → `bugfix`
- Contains "add", "implement", "create", "feature" → `feature`
- Contains "refactor", "cleanup", "restructure" → `refactor`
- Contains "analyze", "explore", "understand", "how does" → `analysis`

### Significance Detection
- More than 3 tool calls involving file edits
- Conversation longer than 10 exchanges
- Error messages were discussed and resolved

## Configuration

In plugin settings:
```json
{
  "auto_save": true,      // Enable this hook
  "auto_save_prompt": true,  // Ask before saving (false = silent save)
  "min_changes_threshold": 3  // Minimum file changes to trigger
}
```

## Integration

This hook works with:
- `/rag-save` command for actual saving
- `documenter` agent for document generation
- Pinecone MCP for storage

## Privacy Note

Documents are saved to the configured vector database. Ensure sensitive information is appropriate for storage. Consider:
- API keys should never be in documents
- Personal data should be anonymized
- Proprietary code should use local storage (Chroma) option
