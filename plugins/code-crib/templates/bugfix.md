---
template: bugfix
description: Template for documenting bug fixes
---

# Bug Fix Documentation Template

Use this template when documenting bug fixes and error resolutions.

## Template Structure

```markdown
---
type: bugfix
date: {{date}}
tags: [{{tags}}]
files: [{{files}}]
title: {{title}}
---

# {{title}}

## Symptom
<!-- What was the observable problem? How did users/developers notice it? -->
{{symptom_description}}

## Reproduction
<!-- Steps to reproduce the bug (if applicable) -->
1. {{step_1}}
2. {{step_2}}
3. {{expected_vs_actual}}

## Root Cause
<!-- Technical explanation of why this happened -->
{{root_cause}}

## Solution
<!-- How the bug was fixed -->
{{solution}}

## Code Changes
<!-- Specific files and changes made -->
{{changes}}

## Testing
<!-- How the fix was verified -->
{{testing}}

## Prevention
<!-- How to prevent this bug from recurring -->
{{prevention}}
```

## Field Guidelines

### Symptom
- Be specific about observable behavior
- Include error messages verbatim
- Note when and how often it occurred

### Root Cause
- Explain the technical reason
- Reference relevant code paths
- Note any contributing factors

### Solution
- Describe the fix approach
- Explain why this approach was chosen
- Note any alternatives considered

### Prevention
- Suggest tests to add
- Note monitoring to implement
- Document patterns to avoid
