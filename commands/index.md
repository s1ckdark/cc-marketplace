---
name: rag-index
description: Bulk index local markdown documents to the RAG knowledge base
arguments:
  - name: path
    description: Path to directory containing markdown files (default .rag-docs/)
    required: false
    type: string
  - name: namespace
    description: Project namespace for all indexed documents
    required: false
    type: string
  - name: force
    description: Re-index existing documents
    required: false
    type: boolean
---

# RAG Index Command

Bulk index local markdown documents into the vector database.

## Instructions

1. **Locate documents**:
   - Default path: `.rag-docs/` in current project
   - Scan for all `.md` files recursively
   - Report total files found

2. **Parse each document**:
   - Extract YAML frontmatter for metadata
   - Expected frontmatter fields:
     ```yaml
     ---
     type: bugfix | feature | refactor | analysis
     date: YYYY-MM-DD
     tags: [tag1, tag2]
     files: [file1.ts, file2.ts]
     title: Document Title
     ---
     ```
   - Document body is the content for embedding

3. **Generate record IDs**:
   - Format: `{{namespace}}-{{date}}-{{filename-hash}}`
   - Check for existing records unless `--force` is set

4. **Batch upsert to Pinecone**:
   ```
   Use upsert-records tool with batch of records:
   - Process in batches of 10-20 documents
   - Index: claude-code-rag
   - Namespace: provided or derived from project directory
   ```

5. **Report progress**:
   ```
   Indexing: 15/45 documents...
   Indexed: document-title-1
   Indexed: document-title-2
   Skipped (exists): document-title-3
   ...
   Complete: 40 indexed, 5 skipped
   ```

6. **Handle errors gracefully**:
   - Skip malformed documents with warning
   - Continue on individual failures
   - Report summary at end

## Directory Structure Expected

```
.rag-docs/
├── 2024-01-15-session-timeout-fix.md
├── 2024-01-16-user-auth-feature.md
├── 2024-01-17-db-migration-analysis.md
└── archived/
    └── 2023-12-old-document.md
```

## Example Usage

```
/rag-index
/rag-index --path ./docs/knowledge
/rag-index --namespace my-project --force
```

## Frontmatter Template

```yaml
---
type: bugfix
date: 2024-01-19
tags: [authentication, session, middleware]
files: [auth/middleware.ts, utils/session.ts]
title: Session Timeout Bug Fix
---

# Session Timeout Bug Fix

## Problem
...
```
