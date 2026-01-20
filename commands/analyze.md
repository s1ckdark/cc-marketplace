---
name: rag-analyze
description: Analyze codebase structure and generate RAG-indexed documentation for each directory
arguments:
  - name: path
    description: Root path to analyze (default: current directory)
    required: false
    type: string
  - name: depth
    description: Maximum directory depth to traverse (default: 4)
    required: false
    type: number
  - name: top
    description: Number of top-priority directories for deep analysis (default: 20)
    required: false
    type: number
  - name: namespace
    description: Project namespace for RAG indexing
    required: false
    type: string
---

# RAG Analyze Command

Analyze project structure and generate searchable documentation for each directory.

## Instructions

**Use the `codebase-analyzer` agent via Task tool to perform the analysis.**

### Step 1: Launch Codebase Analyzer Agent

```
Use Task tool with:
- subagent_type: "claude-code-rag:codebase-analyzer"
- prompt: Include the following parameters:
  - Root path: {{path}} or current directory
  - Max depth: {{depth}} or 4
  - Top N for deep analysis: {{top}} or 20
  - Namespace: {{namespace}} or project directory name
```

### Step 2: Agent Will Execute

The codebase-analyzer agent will:

1. **Phase 1 - Breadth-First Scan**:
   - Scan all directories up to max depth
   - Skip: node_modules, .git, dist, build, __pycache__, etc.
   - Generate quick summaries for each directory
   - Save to `.rag-docs/structure/`

2. **Phase 2 - Deep Analysis**:
   - Calculate priority scores for all directories
   - Analyze top N high-priority directories in detail
   - Read READMEs, entry files, analyze exports/imports
   - Update documentation with enriched content

3. **Phase 3 - RAG Indexing**:
   - Parse generated markdown documents
   - Upsert to Pinecone index `claude-code-rag`
   - Use provided namespace

### Step 3: Report Results

After agent completes, display summary:
- Directories scanned
- Documents generated
- Top priority directories with scores
- RAG indexing status

## Example Usage

```bash
# Analyze current project
/rag-analyze

# Analyze specific path with custom depth
/rag-analyze --path ./packages/core --depth 5

# Analyze with more deep-analysis targets
/rag-analyze --top 30 --namespace my-monorepo
```

## Example Task Prompt

```
Analyze the codebase at [path] with the following settings:
- Maximum depth: [depth]
- Top directories for deep analysis: [top]
- Namespace for RAG indexing: [namespace]

Execute the hybrid analysis:
1. Phase 1: Quick breadth-first scan of all directories
2. Phase 2: Deep analysis of top priority directories
3. Phase 3: Index all generated documents to Pinecone

Save outputs to .rag-docs/structure/ and report the summary.
```
