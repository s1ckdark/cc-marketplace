---
name: analyze
description: Analyze codebase structure and generate searchable docs. Use when the user wants to analyze, scan, or document their project structure.
---

# Analyze / Scope

Scope out your codebase and generate searchable docs for each directory.

## Usage

```
/code-crib:analyze                 # (scope command)
/code-crib:scope --path ./packages/core --depth 5
/code-crib:analyze --top 30 --namespace my-monorepo
```

## Parameters

- `path`: Root path to analyze (default: current directory)
- `depth`: Maximum directory depth to traverse (default: 4)
- `top`: Number of top-priority directories for deep analysis (default: 20)
- `namespace`: Project namespace for RAG indexing

## Instructions

### Phase 1 - Breadth-First Scan

1. Scan all directories up to max depth
2. Skip: node_modules, .git, dist, build, __pycache__, etc.
3. Generate quick summaries for each directory
4. Save to `.rag-docs/structure/`

### Phase 2 - Deep Analysis

1. Calculate priority scores for all directories based on:
   - File count and types
   - README presence
   - Import/export patterns
2. Analyze top N high-priority directories in detail
3. Read READMEs, entry files, analyze exports/imports
4. Update documentation with enriched content

### Phase 3 - RAG Indexing

1. Parse generated markdown documents
2. Upsert to Pinecone index `code-crib`
3. Use provided namespace

### Report Results

Display summary:
- Directories scanned
- Documents generated
- Top priority directories with scores
- RAG indexing status
