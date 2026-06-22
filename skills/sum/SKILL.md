---
name: sum
description: Consolidate the current session's user messages into the current request. Use when Codex needs a concise, up-to-date statement of the user's intent after iterative clarification, correction, or refinement.
---

# Sum

Consolidate only the current session's user messages.

- Preserve earlier requirements unless a later user message replaces, corrects, cancels, or narrows them.
- Merge later elaboration with compatible earlier requirements.
- Remove superseded, cancelled, duplicated, and incidental conversational content.
- Use assistant messages only to resolve references in user messages; never treat them as a source of requirements.
- Return the concise current request, not a transcript or an explanation of the consolidation.
