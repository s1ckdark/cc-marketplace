---
name: search
description: Search docs from your knowledge stash. Use when the user wants to find, search, or look up previous work, solutions, or documentation.
---

# Search / Grab

Grab relevant docs from your knowledge stash.

## Usage

```
/code-crib:grab "session timeout handling"   # (grab command)
/code-crib:grab "authentication" --type bugfix --limit 3
/code-crib:grab "auth bug" --project other-app  # (shared mode only)
```

## Parameters

- `query` (required): Search query describing what you're looking for
- `limit`: Maximum number of results (default 5)
- `type`: Filter by work type (bugfix, feature, refactor, analysis)
- `project`: Filter by project name (shared mode only)
- `tags`: Filter by tags (comma-separated)

## Instructions

### Step 1: Determine Collection Name

Read `code-crib.local.md` in the plugin directory to get configuration:

```yaml
collection_mode: project | shared
```

**Collection Name Logic**:
- **project mode**: `code-crib-{current-directory-name}`
  - Example: Working in `/Users/dave/my-app` → collection: `code-crib-my-app`
- **shared mode**: `code-crib`
  - All projects share this collection
  - Filter by `project` metadata field

### Step 2: Determine Vector DB Backend

Read `code-crib.local.md` to get `vector_db` setting:
- `chroma-docker` or `chroma-local` → Use Chroma MCP tools
- `pinecone` → Use Pinecone MCP tools

### Step 3: Execute Vector Search

**For Chroma** (vector_db: chroma-docker or chroma-local):
```
Use chroma_query_documents tool with:
- collection_name: determined from Step 1
- query_texts: [user's search text]
- n_results: limit (default 5)
- where: metadata filters (type, project if shared mode)
```

**For Pinecone** (vector_db: pinecone):
```
Use search-records tool with:
- Index: code-crib
- Namespace: project name (project mode) or search all (shared mode)
- Query: user's search text
- TopK: limit (default 5)
- Rerank with pinecone-rerank-v0 for better relevance
```

### Step 4: Apply Filters

Build metadata filter based on arguments:

```python
where_filter = {}

# Type filter
if type_arg:
    where_filter["type"] = type_arg

# Project filter (shared mode only)
if collection_mode == "shared" and project_arg:
    where_filter["project"] = project_arg
```

### Step 5: Format Results

```markdown
## Found {{count}} relevant documents

### 1. {{title}} ({{type}}, {{date}})
**Project**: {{project}}
**Tags**: {{tags}}
**Path**: {{path}}

**Summary**: {{first 200 chars of content}}

---
```

### Step 6: Find Related Documents

For top 3 results, find related documents by shared tags:
1. Extract tags from result
2. Query for documents sharing 2+ tags
3. Exclude already-shown results
4. Show top 2 related per result

```markdown
📎 **Related**:
- {{related_title}} - shares: {{shared_tags}}
```

### Step 7: Provide Insights

- How past solutions might apply to current problem
- Context differences that might affect applicability
- Which document to explore further

## Search Tips

- Use specific technical terms for precise results
- Include error messages or function names when searching for bugs
- In shared mode, use `--project` to focus on specific project
- Combine with type filter for focused results
