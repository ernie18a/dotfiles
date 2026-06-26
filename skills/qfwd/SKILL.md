---
name: qfwd
description: Use when the user provides one or more high-level directions, frameworks, or topics and wants to enumerate concrete, implementable sub-items beneath them. Also use when refining, correcting, simplifying, or improving any user-provided script, prompt, specification, skill, policy, documentation, workflow, or structured text by removing accumulated patches, redundant constraints, stale assumptions, and over-specific wording. Best for making artifacts cleaner, more adaptable, and closer to the user's actual intent without overfitting to any particular example.
---

# Framework Decomposition

## Core task

Given one or more parent directions, enumerate their concrete sub-items.
Apply this regardless of domain.

## Rules

1. **Specific over abstract.** Each sub-item must be concrete enough to start implementing immediately — name the algorithm, method, or deliverable, not the concept.
2. **Include both theory and engineering.** Every direction has a math component and a data/pipeline component. Both are sub-items.
3. **Mark cross-dependencies.** If a sub-item feeds into or receives from another parent direction, note it inline.
4. **Do not add content from outside the user's scope.** Derive sub-items from the parent's own definition only.
5. **When simplifying an artifact**, remove before adding. Strip over-specification, hardcoded examples, and literalized constraints first, then improve.

## Output format

```
## [Parent Direction]

1. [Concrete sub-item]
2. [Concrete sub-item]  [→ feeds: AnotherDirection]
3. ...
```

Flat list. No prose summaries. No grouping headers unless the list exceeds 12 items.
