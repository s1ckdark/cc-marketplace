---
template: refactor
description: Template for documenting code refactoring
---

# Refactoring Documentation Template

Use this template when documenting code restructuring without behavior change.

## Template Structure

```markdown
---
type: refactor
date: {{date}}
tags: [{{tags}}]
files: [{{files}}]
title: {{title}}
---

# {{title}}

## Motivation
<!-- Why was this refactoring needed? -->
{{motivation}}

## Before State
<!-- How the code was structured before -->
{{before_state}}

## After State
<!-- How the code is structured now -->
{{after_state}}

## Changes Made
<!-- Specific transformations applied -->
{{changes}}

## Benefits
<!-- What improved as a result -->
{{benefits}}

## Verification
<!-- How we ensured behavior didn't change -->
{{verification}}

## Migration Notes
<!-- Any breaking changes or migration steps -->
{{migration_notes}}
```

## Field Guidelines

### Motivation
- Describe the code smell or problem
- Note impact on maintainability
- Reference any metrics (complexity, duplication)

### Before/After State
- Show relevant code structure
- Use diagrams if helpful
- Highlight key differences

### Benefits
- Quantify improvements if possible
- Note developer experience improvements
- Document performance impacts

### Verification
- List tests run
- Note manual verification done
- Document any regression testing
