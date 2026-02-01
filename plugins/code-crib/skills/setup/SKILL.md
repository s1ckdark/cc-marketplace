---
name: setup
description: Interactive setup wizard for code-crib - choose vector DB and collection mode. Use when user wants to set up, configure, or initialize code-crib.
---

# Code-Crib Setup Wizard

Interactive setup for first-time configuration.

## Usage

```
/setup
```

## Instructions

### Step 1: Welcome Message

Display:
```
🏠 Code-Crib Setup Wizard

Let's configure your knowledge stash!
```

### Step 2: Ask Vector DB Choice

Use AskUserQuestion tool:

```yaml
question: "Which vector database do you want to use?"
header: "Vector DB"
options:
  - label: "Chroma + Docker (Recommended)"
    description: "Run Chroma in Docker container. Clean isolation, easy setup."
  - label: "Chroma + Python local"
    description: "Install Chroma via pip. No Docker required."
  - label: "Pinecone (Cloud)"
    description: "Cloud-hosted vector DB. Requires API key."
```

### Step 3: Ask Collection Mode

Use AskUserQuestion tool:

```yaml
question: "How do you want to organize your knowledge?"
header: "Mode"
options:
  - label: "Project mode (Recommended)"
    description: "Each project gets isolated collection. No cross-contamination."
  - label: "Shared mode"
    description: "All projects share one collection. Cross-project search enabled."
```

### Step 3.5: Ask Auto-RAG Setting

Use AskUserQuestion tool:

```yaml
question: "Enable automatic knowledge retrieval? (RAG)"
header: "Auto-RAG"
options:
  - label: "Enabled (Recommended)"
    description: "Automatically search past knowledge when you ask questions. Context injected seamlessly."
  - label: "Disabled"
    description: "Only search when you explicitly use /grab. More control, less magic."
```

### Step 4: Generate Configuration

Based on answers, create/update `code-crib.local.md` in the plugin directory:

**For Chroma + Docker:**
```yaml
---
collection_mode: {project|shared}
vector_db: chroma-docker
chroma:
  host: localhost
  port: 8000
auto_rag:
  enabled: {true|false}
  max_results: 3
  min_relevance: 0.7
---
```

**For Chroma + Python local:**
```yaml
---
collection_mode: {project|shared}
vector_db: chroma-local
chroma:
  host: localhost
  port: 8000
auto_rag:
  enabled: {true|false}
  max_results: 3
  min_relevance: 0.7
---
```

**For Pinecone:**
```yaml
---
collection_mode: {project|shared}
vector_db: pinecone
pinecone:
  index: code-crib
auto_rag:
  enabled: {true|false}
  max_results: 3
  min_relevance: 0.7
---
```

### Step 5: Update .mcp.json if needed

**For Chroma (Docker or Local):** Ensure `disabled: false`
```json
{
  "mcpServers": {
    "chroma": {
      "disabled": false
    }
  }
}
```

**For Pinecone:** Can disable chroma (optional)
```json
{
  "mcpServers": {
    "chroma": {
      "disabled": true
    }
  }
}
```

Note: Pinecone requires PINECONE_API_KEY environment variable.

### Step 5.5: Auto-Configure Permissions for Seamless Indexing

**Automatically add Chroma tools to auto-approve in `~/.claude/settings.json`.**

1. Read current `~/.claude/settings.json` (create if not exists)
2. Merge the following permissions into `permissions.allow` array:

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

3. Write back the merged settings.json

**Example merge logic:**
```
existing = read ~/.claude/settings.json or {}
existing.permissions = existing.permissions or {}
existing.permissions.allow = existing.permissions.allow or []
existing.permissions.allow = dedupe(existing.permissions.allow + chroma_tools)
write ~/.claude/settings.json
```

4. Report to user:
```
✅ Auto-approve configured for Chroma tools
   - Zero-confirmation indexing with /rack
   - Seamless Auto-RAG searches
```

### Step 6: Show Next Steps

**If Chroma + Docker:**
```
✅ Setup complete!

Next steps:
1. Start Chroma server:
   docker run -p 8000:8000 chromadb/chroma

2. Test your setup:
   /grab "test query"

Configuration saved to: code-crib.local.md
```

**If Chroma + Python:**
```
✅ Setup complete!

Next steps:
1. Install Chroma:
   pip install chromadb

2. Start Chroma server:
   chroma run --host localhost --port 8000

3. Test your setup:
   /grab "test query"

Configuration saved to: code-crib.local.md
```

**If Pinecone:**
```
✅ Setup complete!

Next steps:
1. Get API key from https://pinecone.io

2. Add to ~/.claude/settings.json:
   {
     "env": {
       "PINECONE_API_KEY": "your-api-key"
     }
   }

3. Create index via Pinecone console (dimension: 1536)

4. Test your setup:
   /grab "test query"

Configuration saved to: code-crib.local.md
```

## Configuration File Location

The configuration file is saved at:
`${CLAUDE_PLUGIN_ROOT}/code-crib.local.md`

This file is git-ignored and contains your local preferences.
