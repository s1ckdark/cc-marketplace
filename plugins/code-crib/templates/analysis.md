---
template: analysis
description: Template for documenting code analysis and exploration
---

# Analysis Documentation Template

Use this template when documenting code exploration and architectural analysis.

## Template Structure

```markdown
---
type: analysis
date: {{date}}
tags: [{{tags}}]
files: [{{files}}]
title: {{title}}
---

# {{title}}

## Question
<!-- What was being investigated? -->
{{question}}

## Context
<!-- Background information relevant to the analysis -->
{{context}}

## Analysis Process
<!-- How the investigation was conducted -->
{{analysis_process}}

## Findings
<!-- What was discovered -->
{{findings}}

## Key Code Locations
<!-- Important files and functions discovered -->
{{key_code}}

## Architecture Notes
<!-- Relevant architectural insights -->
{{architecture}}

## Conclusions
<!-- Summary and implications -->
{{conclusions}}

## Related Topics
<!-- Links to related analyses or documentation -->
{{related}}
```

## Field Guidelines

### Question
- State the question clearly
- Note what prompted the investigation
- Define scope of analysis

### Analysis Process
- Document the exploration steps
- Note tools and commands used
- Record dead ends and redirections

### Findings
- Present discoveries clearly
- Include code references
- Note surprises or unexpected findings

### Conclusions
- Summarize key takeaways
- Note actionable insights
- Suggest follow-up investigations
