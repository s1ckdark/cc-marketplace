---
name: rag-search
description: Search the RAG knowledge base for relevant past work and solutions
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
---

# RAG Search Command

Search the vector database for relevant past work, solutions, and analyses.

## Instructions

1. **Prepare search query**:
   - Use the provided query text
   - Enhance with context from current conversation if relevant

2. **Execute vector search** using Pinecone MCP:
   ```
   Use search-records tool with:
   - Index: claude-code-rag
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

5. **Provide actionable insights**:
   - Highlight how past solutions might apply to current problem
   - Note any differences in context that might affect applicability
   - Suggest which document to explore further

## Example Usage

```
/rag-search "session timeout handling"
/rag-search "authentication" --type bugfix --limit 3
/rag-search "database migration" --namespace my-project
```

## Search Tips

- Use specific technical terms for precise results
- Include error messages or function names when searching for bugs
- Combine with type filter for focused results
- Search across namespaces for cross-project learning
