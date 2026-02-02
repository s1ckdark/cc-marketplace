---
name: inject
description: Manually inject file or context into current conversation. Use when user wants to add specific files or context without RAG search.
---

# Inject Context

Manually inject specific files or context into the current conversation without RAG search.

## Usage

```
/inject src/auth/login.ts              # Single file
/inject src/components/*.tsx           # Glob pattern
/inject src/api/ --depth 2             # Directory with depth
/inject CODEBASE.md                    # Documentation file
```

## When to Use

| Scenario | Command |
|----------|---------|
| "I need this file in context" | `/inject path/to/file` |
| "Add all components" | `/inject src/components/*.tsx` |
| "Include the API docs" | `/inject docs/api.md` |

**Key difference from `/rag`:**
- `/rag "question"` → Searches and finds relevant context automatically
- `/inject path` → You specify exactly what to include (no search)

## Parameters

- `path` (required): File path or glob pattern
- `--depth N`: For directories, max depth to traverse (default: 1)
- `--summary`: Include only file summaries, not full content

## Instructions

### Step 1: Parse Arguments

```
path = first argument (required)
depth = --depth value (default 1)
summary_only = --summary flag present
```

### Step 2: Resolve Paths

**Single file:**
```
/inject src/auth.ts
→ Read src/auth.ts
```

**Glob pattern:**
```
/inject src/**/*.test.ts
→ Glob match, read all matching files
```

**Directory:**
```
/inject src/components/
→ List files up to --depth
→ Read each file
```

### Step 3: Read Content

For each resolved file:

1. Check file exists
2. Check file size (warn if > 50KB)
3. Read content

**Large file handling:**
```markdown
⚠️ Large file: src/generated/schema.ts (150KB)
Injecting summary only. Use `/inject path --full` to include entire content.
```

### Step 4: Format Output

```markdown
## Injected Context

### 📄 src/auth/login.ts
```typescript
// File content here
export function login(credentials: Credentials) {
  // ...
}
```

### 📄 src/auth/logout.ts
```typescript
// File content here
export function logout() {
  // ...
}
```

---
✅ Injected {{count}} files into context
```

### Step 5: Provide Summary

```markdown
## Summary

| File | Lines | Purpose |
|------|-------|---------|
| login.ts | 45 | User authentication |
| logout.ts | 12 | Session cleanup |

**Total**: {{total_lines}} lines from {{file_count}} files

💡 This context is now available for the current conversation.
   Ask questions or request changes based on this code.
```

## Error Handling

**File not found:**
```markdown
❌ File not found: src/auth/login.ts

Did you mean:
- src/authentication/login.ts
- src/auth/Login.tsx
```

**No matches for glob:**
```markdown
❌ No files match pattern: src/**/*.spec.ts

Try:
- src/**/*.test.ts
- src/**/*.spec.tsx
```

**Permission denied:**
```markdown
❌ Cannot read: /etc/passwd (permission denied)

Only project files can be injected.
```

## Tips

- Use glob patterns for related files: `/inject src/hooks/use*.ts`
- Include test files for context: `/inject src/auth/ && /inject tests/auth/`
- For large directories, use `--summary` first to preview
