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

## Overview

This command runs a **hybrid analysis**:
1. **Phase 1**: Quick breadth-first scan of all directories
2. **Phase 2**: Deep analysis of high-priority directories

## Instructions

### Step 1: Initialize

1. Determine root path (argument or current directory)
2. Detect project type from config files:
   - `package.json` → Node.js/JavaScript
   - `pyproject.toml` / `setup.py` → Python
   - `Cargo.toml` → Rust
   - `go.mod` → Go
   - `pom.xml` / `build.gradle` → Java
3. Create output directory: `.rag-docs/structure/`

### Step 2: Phase 1 - Breadth-First Scan

```
For each directory (up to max depth):
  Skip if in ignore list:
    - node_modules, vendor, .venv, __pycache__
    - .git, .svn, .hg
    - dist, build, out, target
    - .cache, .tmp

  Collect metadata:
    - path: relative path from root
    - name: directory name
    - fileCount: number of files
    - fileTypes: extensions found
    - hasReadme: boolean
    - hasConfig: boolean (index.ts, __init__.py, mod.rs)
    - subdirs: list of subdirectory names

  Generate quick summary (1-2 sentences based on name and contents)

  Save basic entry to .rag-docs/structure/{path-slug}.md
```

### Step 3: Calculate Priority Scores

```
For each scanned directory:
  score = 0

  // File count (max 30)
  score += min(30, floor(fileCount / 10) * 10)

  // README bonus (+20)
  if hasReadme: score += 20

  // Import frequency (max 25)
  importCount = grep for imports pointing to this directory
  score += min(25, importCount * 5)

  // Core directory bonus (+15)
  if name in [src, lib, core, app, packages, modules]: score += 15

  // Depth penalty (max -10)
  score -= min(10, (depth - 1) * 5)

Sort directories by score descending
```

### Step 4: Phase 2 - Deep Analysis

```
For top N directories (default 20):
  1. Read README.md if exists
  2. Read main entry file (index.ts, __init__.py, mod.rs)
  3. Analyze exports/public API
  4. Identify patterns:
     - Component library?
     - Utility functions?
     - API routes?
     - Data models?
  5. Map dependencies (imports from other directories)
  6. Generate detailed documentation
  7. Update .rag-docs/structure/{path-slug}.md with enriched content
```

### Step 5: Index to Vector DB

```
For each generated document:
  1. Parse frontmatter
  2. Generate record ID: {namespace}-structure-{path-hash}
  3. Upsert to Pinecone:
     - index: claude-code-rag
     - namespace: provided or project directory name
```

### Step 6: Report Summary

```
📊 Codebase Analysis Complete

Project: {project-name} ({project-type})
Root: {root-path}

Phase 1 (Quick Scan):
  ├─ Directories scanned: 45
  ├─ Files discovered: 312
  └─ Basic entries created: 45

Phase 2 (Deep Analysis):
  ├─ High-priority directories: 20
  ├─ Detailed docs generated: 20
  └─ Top directories:
     1. src/components (score: 85)
     2. src/lib (score: 75)
     3. src/api (score: 70)
     ...

RAG Indexing:
  ├─ Documents indexed: 45
  ├─ Namespace: {namespace}
  └─ Index: claude-code-rag

Output: .rag-docs/structure/
```

## Example Usage

```bash
# Analyze current project
/rag-analyze

# Analyze specific path with custom depth
/rag-analyze --path ./packages/core --depth 5

# Analyze with more deep-analysis targets
/rag-analyze --top 30 --namespace my-monorepo
```

## Output Format

Each generated document follows this structure:

```markdown
---
type: codebase-structure
date: 2024-01-20
tags: [component, react, ui]
path: src/components
score: 85
project: my-app
title: Components - Reusable React UI Components
---

# src/components

## Purpose
[1-2 sentence summary]

## Key Files
- index.ts - Barrel exports
- Button/Button.tsx - Primary button component

## Structure
- atoms/ - Basic building blocks
- molecules/ - Composite components

## Dependencies
- ../hooks - Custom React hooks
- ../styles - Shared styles

## Dependents
- ../pages - All page components
- ../app - Main application

## Patterns
- Atomic design structure
- Each component has co-located tests
```

## Notes

- First run may take 1-2 minutes for large codebases
- Re-running updates existing entries (incremental)
- Use `--namespace` for monorepos to separate projects
