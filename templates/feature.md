---
template: feature
description: Template for documenting new features
---

# Feature Documentation Template

Use this template when documenting new functionality additions.

## Template Structure

```markdown
---
type: feature
date: {{date}}
tags: [{{tags}}]
files: [{{files}}]
title: {{title}}
---

# {{title}}

## Requirements
<!-- What functionality was needed? -->
{{requirements}}

## Design Decisions
<!-- Key architectural and design choices -->
{{design_decisions}}

## Implementation
<!-- How the feature was built -->
{{implementation}}

## API/Interface
<!-- Public interfaces exposed (if applicable) -->
{{api_interface}}

## Testing
<!-- How the feature was tested -->
{{testing}}

## Usage Examples
<!-- How to use the new feature -->
{{usage_examples}}

## Future Considerations
<!-- Potential improvements or related work -->
{{future_considerations}}
```

## Field Guidelines

### Requirements
- List functional requirements
- Note non-functional requirements (performance, security)
- Reference any specs or tickets

### Design Decisions
- Document major choices and rationale
- Note alternatives considered
- Explain trade-offs made

### Implementation
- Describe the architecture
- Note key patterns used
- Reference important code sections

### Usage Examples
- Provide code snippets
- Show common use cases
- Note any gotchas
