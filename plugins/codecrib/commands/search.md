---
name: search
description: Search your stash for past work and solutions (alias: /grab)
arguments:
  - name: query
    description: Search query describing what you're looking for
    required: true
    type: string
  - name: limit
    description: Maximum number of results (default 5)
    required: false
    type: number
  - name: type
    description: Filter by work type (bugfix, feature, refactor, analysis)
    required: false
    type: string
  - name: namespace
    description: Search within specific project namespace
    required: false
    type: string
  - name: tags
    description: Filter by tags (comma-separated)
    required: false
    type: string
  - name: project
    description: Filter by project name (shared mode only)
    required: false
    type: string
---

# Search Command

Grab relevant docs from your knowledge stash.

## Instructions

1. **Prepare search query**:
   - Use the provided query text
   - Enhance with context from current conversation if relevant

2. **Execute vector search** using Pinecone MCP:
   ```
   Use search-records tool with:
   - Index: codecrib
   - Namespace: provided or search all
   - Query: user's search text
   - TopK: limit (default 5)
   - Rerank with pinecone-rerank-v0 for better relevance
   ```

3. **Apply filters** if provided:
   - Filter by `type` field if type argument given
   - Filter by `tags` field if tags argument given
   - Namespace restricts to specific project

4. **Format results** for user:
   ```markdown
   ## Found {{count}} relevant documents

   ### 1. {{title}} ({{type}}, {{date}})
   **Tags**: {{tags}}
   **Files**: {{files}}

   **Summary**: {{first 200 chars of content}}

   ---
   ```

5. **Find related documents** (for top 3 results):

   For each of the top 3 search results, find related documents:

   a. Extract tags from the result document
   b. Query Pinecone for documents sharing 2+ tags with this result
   c. Exclude documents already in main results
   d. Take top 2 most similar by score
   e. Append to result display

   ```markdown
   ### 1. {{title}} ({{type}}, {{date}})
   **Tags**: {{tags}}
   **Summary**: {{first 200 chars}}

     📎 **Related**:
     - {{related1_title}} ({{related1_type}}) - shares: {{shared_tags}}
     - {{related2_title}} ({{related2_type}}) - shares: {{shared_tags}}
   ```

   **Related Document Query Logic**:
   ```
   For each top result (max 3):
     1. Get tags array from result metadata
     2. Search with filter: tags has ANY of [result_tags]
     3. Filter out: current result ID, other main results
     4. Sort by: number of shared tags DESC, then similarity score DESC
     5. Take top 2
   ```

   **Skip related search if**:
   - Result has fewer than 2 tags
   - User specified --no-related flag
   - Total results < 3 (focus on main results)

6. **Provide actionable insights**:
   - Highlight how past solutions might apply to current problem
   - Note any differences in context that might affect applicability
   - Suggest which document to explore further

## Example Usage

```
/search "session timeout handling"   # or /grab
/grab "authentication" --type bugfix --limit 3
/search "database migration" --namespace my-project
```

## Search Tips

- Use specific technical terms for precise results
- Include error messages or function names when searching for bugs
- Combine with type filter for focused results
- Search across namespaces for cross-project learning
