---
name: os
description: Manual invocation only
---

# os Handoff

Create one `osNN.md` code-implementation handoff for a downstream agent.
The handoff is for writing code only. It is invalid if it is a status report,
architecture report, completion report, or architecture-only plan.

Before writing:

1. Read the user request and target project's governing instructions.
2. For code-affecting work, inspect the directly related code paths before writing the handoff; do not use documents, summaries, or assumptions as substitutes for code facts.
3. Derive the handoff direction from the inspected code: identify the smallest code path, contract, or behavior boundary that can satisfy the user's goal.
4. Investigate and include only facts or choices that can change Scope or a Phase's Action.
5. Resolve each relevant choice using code facts. If more than one valid direction remains, write the decision rule and boundaries the executor must follow instead of turning the unresolved choice into a fixed internal sequence.
6. Carry the resulting constraints and decisions into Scope or Action.

Handoff rules:
- Keep one main goal and divide work into concrete code-edit phases.
- State allowed and forbidden scope.
- Make the handoff self-contained: the executor can complete the requested code work using only the handoff and the execution targets it explicitly names. If removing prior conversation or non-target references makes the handoff insufficient, extract the missing contracts into the handoff. Mention a source only when the executor must inspect, modify, or preserve it.
- If the user does not specify a target directory, treat the directory containing the generated `osNN.md` as the target root. Do not invent another project path or subdirectory unless the user request or inspected code contract requires it.
- For system-scale work, write the first slice that creates an executable entry point with input format, persisted state if needed, output behavior, and failure behavior. Do not write a speculative roadmap.
- Unless the user explicitly asks for testing, validation, or checks, the handoff must not instruct or imply that the downstream agent should create tests, run tests, run validation commands, inspect output, collect evidence, confirm behavior, or write reports. The handoff may still define product or runtime completion behavior.
- Reject architecture, module lists, dependency plans, phase sequences, or abstractions that are not required to decide files, contracts, or behavior boundaries.

Name handoffs incrementally: `os01.md`, `os02.md`.

## `osNN.md` Template

```md
# osNN

## Goal

- terminal:
- current code slice:

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

- Reply exactly `DONE` when the requested code work is complete.

```
