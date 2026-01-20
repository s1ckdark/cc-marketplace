---
name: rag-save
description: Save current work as a structured document to the RAG knowledge base
arguments:
  - name: type
    description: "Work type: bugfix, feature, refactor, analysis"
    required: false
    type: string
  - name: title
    description: Document title (auto-generated if not provided)
    required: false
    type: string
  - name: tags
    description: Comma-separated tags for categorization
    required: false
    type: string
  - name: namespace
    description: Project namespace for organization
    required: false
    type: string
---

# RAG Save Command

Save the current work session as a structured document to the vector database.

## Instructions

**Use the `documenter` agent via Task tool to generate the document.**

### Step 1: Launch Documenter Agent

```
Use Task tool with:
- subagent_type: "claude-code-rag:documenter"
- prompt: Include the following context:
  - Work type: {{type}} or auto-detect from conversation
  - Title: {{title}} or auto-generate
  - Tags: {{tags}} or auto-extract
  - Namespace: {{namespace}} or project directory name
  - Full conversation context for analysis
```

### Step 2: Agent Will Execute

The documenter agent will:

1. **Analyze Conversation**:
   - Identify problem being solved
   - Extract solution implemented
   - List files modified
   - Capture key learnings

2. **Classify Work Type** (if not provided):
   - `bugfix`: Bug fixes, error resolutions
   - `feature`: New functionality added
   - `refactor`: Code restructuring
   - `analysis`: Code exploration, architecture review

3. **Generate Structured Document**:
   - Use appropriate template from `/templates/`
   - Include frontmatter metadata
   - Format for optimal RAG retrieval

4. **Extract Metadata**:
   - Auto-detect tags from code patterns
   - List all modified files
   - Generate searchable keywords

### Step 3: Save to Vector Database

After agent generates document, save to Pinecone:

```
Use Pinecone MCP upsert-records tool:
- index: claude-code-rag
- namespace: {{namespace}} or project name
- record:
  {
    "id": "{{namespace}}-{{timestamp}}-{{hash}}",
    "content": "Full markdown document text",
    "type": "{{type}}",
    "title": "{{title}}",
    "project": "{{namespace}}",
    "date": "{{YYYY-MM-DD}}",
    "tags": "{{comma-separated-tags}}",
    "files": "{{comma-separated-files}}"
  }
```

### Step 4: Confirm to User

Display:
- Document title
- Type and tags
- Files referenced
- Record ID for future reference

## Example Usage

```bash
# Auto-detect everything from conversation
/rag-save

# Specify type and tags
/rag-save --type bugfix --tags "auth,session" --title "Session timeout fix"

# Save to specific namespace
/rag-save --namespace my-project --type feature
```

## Example Task Prompt

```
Analyze the current conversation and generate a structured RAG document:

Settings:
- Work type: [type] (or auto-detect)
- Title: [title] (or auto-generate)
- Tags: [tags] (or auto-extract)
- Namespace: [namespace]

Tasks:
1. Analyze conversation to understand what was accomplished
2. Classify work type if not provided
3. Generate structured markdown document using appropriate template
4. Extract metadata (files modified, tags, keywords)
5. Return the complete document for RAG indexing
```

## Auto-detection Hints

- Conversation mentions "error", "bug", "fix" → `bugfix`
- Conversation mentions "add", "implement", "new feature" → `feature`
- Conversation mentions "refactor", "clean", "restructure" → `refactor`
- Conversation asks "how", "why", "explain" → `analysis`
