---
name: sump
description: Manual invocation only
---

# Sum

Consolidate only the current session's user messages in two stages.

- First, identify and collect what the user has said in the current session.
- Then, organize those messages in chronological order into the concise current request.
- Preserve earlier requirements unless a later user message replaces, corrects, cancels, narrows, or reframes them.
- Treat later user messages as higher-priority evidence when they adjust or converge on earlier intent.
- Merge later elaboration with still-compatible earlier requirements.
- Remove superseded, cancelled, duplicated, and incidental conversational content.
- Use assistant messages only to resolve references in user messages; never treat them as a source of requirements.
- Return the concise current request, not a transcript or an explanation of the consolidation.
