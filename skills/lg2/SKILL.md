---
name: lg2
description: Create one lg2NN.md for LangGraph runtime entry/index workflows, or repair an explicitly identified existing entry.
---

# LG2

## Role

Prepare stable input for the LangGraph runtime. Treat the skill as an entry/index compiler, not as the runtime.

The skill creates one new `lg2NN.md` entry by default, named incrementally like `osNN.md`. It may edit an existing entry only when the user explicitly identifies it as the target or asks for repair. It must not execute worker tasks, mutate `PROGRESS/state.json`, decide terminal completion, or treat model claims, stdout, chat history, `STATUS.md`, or `CONTEXT/*` as canonical state.

## Boundary

`lg2` owns input quality:
- Convert user intent into a compact entry/index contract.
- Preserve only requirements that affect execution, safety, verification, or recovery.
- Identify missing goal, scope, evidence, stop condition, next action, or audit boundary.
- Define the smallest useful task index when one file would grow past what the runtime needs for the next decision.
- Make terminal success and false-success cases observable enough for runtime audit.
- For code-affecting entries, derive scope and action boundaries from directly inspected code contracts and observable behavior.
- Repair an entry when runtime feedback shows ambiguity, missing evidence, or blocker context.

`lg2-run` owns execution:
- Load entry markdown and compute its digest.
- Create or resume `PROGRESS/state.json`.
- Load only referenced task docs needed for the current decision.
- Run graph nodes, worker actions, planner escalation, workspace diffing, and verification.
- Decide `running`, `blocked`, `failed`, or `done` from checkpoint and observable evidence.
- Reject or block on entries that are malformed, unsafe, too broad, or unverifiable.

## Description Discipline

Write for the LangGraph runtime's actual decisions:
- load the entry and any referenced task docs
- choose the next smallest executable action
- reject unsafe, stale, too broad, or unverifiable work
- audit terminal success against observable evidence

Borrow description discipline from narrower handoff formats without copying their execution model:
- From one-shot handoffs, use concrete allowed/forbidden scope, small executable actions, direct verification, and hard stop conditions.
- From planner-worker briefs, use high-value boundaries, fresh evidence requirements, and `Completion Criteria` that make false terminal success hard to satisfy.
- Translate those ideas into the existing `LG2 Entry` fields; do not add phase-completion status, planner-worker protocol details, runtime state fields, or handoff-only report sections unless they are required by the LangGraph runtime contract.

Treat external formats as input-quality lessons, not output templates. The generated artifact must remain compatible with the active `lg2-run` entry contract and the project-specific wrapper, if one exists.

## Entry Contract

Use the smallest entry/index that can be executed, audited, and resumed safely:

```md
# LG2 Entry

## Goal
- terminal:
- current:

## Scope
Allowed:
- ...

Forbidden:
- ...

## Inputs
- ...

## Task Index
- ...

## Next Action
- ...

## Boundaries
- ...

## Evidence Required
- ...

## Verification
- ...

## Completion Criteria
- terminal success:
- required evidence:
- not sufficient:

## Stop
- ...

## Handoff
- ...
```

Rules:
- Keep one primary goal per entry.
- Keep `Next Action` to the next smallest executable workspace action; for code-affecting work, derive it from inspected code rather than documents, summaries, chat history, or assumptions.
- Keep `Boundaries` to the smallest set that blocks high-risk failure: wrong files, false terminal success, stale evidence, unsafe breadth, or hidden external blockers.
- Describe `Scope` as an execution boundary: what may be read, modified, run, or must not be touched.
- Describe `Stop` as concrete runtime blockers: missing required input, scope expansion, unverifiable evidence, unsafe writes, or external authority that cannot be resolved from the workspace.
- Make `Evidence Required` observable through file/content changes, command results, or explicit external input.
- Use `Verification` for concrete commands or deterministic evidence rules. If none is known, state the missing verification instead of inventing one.
- Verification commands must encode their own pass/fail semantics. If success means an operation must fail, wrap that operation in an assertion command that exits 0 only when the expected failure is observed; do not pair a raw failing command with prose that says the failure is acceptable.
- Keep prose-only verification constraints as audit rules, not commands. Prefer clear labels such as `Audit:` for rules like offline-only checks, evidence freshness, protected paths, or no-network requirements.
- Put destructive, production-facing, costly, long-running, or real-service checks behind explicit permission or into `Stop`.
- Treat `Completion Criteria` as the audit oracle. Include what is sufficient, what evidence is required, and what is explicitly not sufficient.
- Use `Handoff` only when the next run cannot continue from the other fields. Keep it short.
- Use `Task Index` only when it reduces repeated reading or editing. Reference stable project-owned docs by path and purpose; do not copy raw logs, chat history, or source files into the entry.
- Split large work into an index entry plus referenced sub-entries instead of growing one file. If a direct one-file entry is safer, omit sub-entries.

## Workflow

1. Check the premise.
   Confirm whether the request is for a new entry, an edit to an existing entry, a repair after runtime feedback, or a boundary/design discussion. For code-affecting work, inspect directly related code paths before compiling entry fields.

2. Remove noise before adding structure.
   Do not preserve chat phrasing, historical explanation, duplicate constraints, or implementation guesses unless they affect execution or verification.

3. Define authority boundaries.
   Decide what the skill can encode as input and what the runtime must prove from checkpoint, workspace tools, provider results, or verification.

4. Compile or repair the entry.
   Fill only the contract fields needed for safe execution and terminal audit. If multiple implementation directions remain valid, write the decision rule and boundaries instead of a fixed internal sequence. If critical information is missing, write it as an explicit blocker or open question.

5. Preserve runtime authority.
   Never mark the task done. Never claim that verification passed unless the runtime or user provides actual evidence.

6. Give the next command when useful.
   Prefer `lg2-run <entry.md>` or the project-specific wrapper once it exists.

## Repair Rules

When runtime feedback says `blocked`, `failed`, or no progress:
- If the blocker is missing input or authority, update `Stop` or ask for the missing input.
- If the blocker is ambiguity, narrow `Goal`, `Scope`, `Task Index`, or `Next Action`.
- If evidence is missing, add `Evidence Required` or `Verification`; do not weaken completion criteria.
- If the worker attempted broad or unsafe work, reduce `Next Action` and tighten `Forbidden`.
- If terminal audit can pass accidentally, tighten `Completion Criteria` and `not sufficient`.
- If evidence may be stale, require fresh evidence tied to the current digest, changed files, command output, or explicit user input.
- If the entry digest changed intentionally, note that the runtime should re-audit or start fresh according to its checkpoint contract.

## Output Discipline

When editing an entry, report only:
- what changed
- what was removed or tightened
- what remains blocked or unverifiable
- the command to run, if execution is the next step

Prefer concise Traditional Chinese when replying to the user unless the edited artifact is already in another language.
