---
name: os
description: Manual invocation only
---

# os Handoff

Create one `osNN.md` for a downstream agent.

Before writing:

1. Read the user request and target project's governing instructions.
2. For code-affecting work, inspect the directly related code paths before writing the handoff; do not use documents, summaries, or assumptions as substitutes for code evidence.
3. Derive the handoff direction from the inspected code: identify the smallest code path, contract, or behavior boundary that can satisfy the user's goal.
4. Investigate and include only facts or choices that can change Scope, a Phase's Action, or Stop.
5. Resolve each relevant choice using code evidence. If more than one valid direction remains, write the decision rule and boundaries the executor must follow instead of turning the unresolved choice into a fixed internal sequence.
6. Carry the resulting constraints and decisions into Scope, Action, or Stop.

Keep one main goal. State the allowed and forbidden scope. Divide work into concrete phases. Do not create new scaffolding or run destructive, production-facing, costly, long-running, or real-service checks unless explicitly allowed.

Name handoffs incrementally: `os01.md`, `os02.md`.

## `osNN.md` Template

```md
# osNN

## Goal

- 最終要完成什麼。

## Scope

Allowed:
- 可改哪些檔案、模組或邊界。

Forbidden:
- 不可碰哪些範圍或改變哪些 contract。

## Phases

### Phase N: 名稱

Action:
- 需要完成什麼。

## Completion

- Reply exactly `DONE`, otherwise, report only the unresolved condition and what is still needed to continue.

```
