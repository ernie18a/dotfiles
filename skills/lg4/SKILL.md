---
name: lg4
description: Manual invocation only
---

# LG4

## Role

Create one `gl3NN.md` entry for `gl3`.

This skill is an entry compiler. It does not execute the task, mutate `PROGRESS/`, decide terminal status, or write runtime reports.

## Boundary

`lg3` owns input shape:
- Convert user intent into a self-contained entry.
- Preserve only requirements that change scope, next action, required output, completion, or stop behavior.
- For code-affecting work, inspect directly related code before setting file/module boundaries.
- Keep planner/audit context complete enough for `gl3`.
- Keep worker action bounded to the next executable batch.

`gl3` owns execution:
- Load entry markdown.
- Manage planner/worker loop, state, workspace diff, command results, terminal receipt, and resume.
- Decide `done`, `blocked`, or `failed`.

## Output File

- Create a root-level `gl3NN.md`, incrementing from existing `gl3*.md`.
- Edit an existing entry only when the user names it.
- Do not reference the source prompt, chat history, or external requirement files as required runtime input.

## Entry Shape

```md
# gl3 entry

## Goal
- terminal:
- current:

## Task Index
- ...

## Next Action
- ...

## Scope
Allowed:
- ...

Forbidden:
- ...

## Required Output
- ...

## Completion
- file:<relative-path>
- cmd:<existing project command>

## Stop
- ...
```

## Rules

- Keep one terminal goal.
- `Next Action` is the next workspace batch, not a roadmap.
- `Task Index` lists only stable project-owned markdown files needed later; omit it when one entry is enough.
- `Scope` defines what may be read or changed and what must not be touched.
- `Required Output` states observable product output, not process notes.
- `Completion` may use existing project commands only.
- Do not require creating new test scripts unless the user explicitly asks for tests.
- If no existing command is known, prefer `file:<relative-path>` completion over inventing a command.
- `Stop` lists blockers the runtime should not resolve autonomously: missing input, scope expansion, destructive action, external authority, or unavailable existing command.
- Do not include runtime protocol schemas, provider internals, `PROGRESS/*`, logs, reports, or worker self-claims as source-of-truth requirements.

## Workflow

1. Classify the request as new entry or repair.
2. Inspect directly related files only when code boundaries affect the entry.
3. Remove duplicated background and historical wording.
4. Write the smallest entry that lets `gl3` choose the next batch and decide terminal status from `Completion`.
5. Reply with the entry path and any unresolved blocker.
