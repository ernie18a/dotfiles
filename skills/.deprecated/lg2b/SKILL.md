---
name: lg2
description: Manual invocation only
---

# LG2

## Role

Create one entry file for the new `./lg2` runtime.

This skill is an entry compiler. It converts natural-language user intent into a compact runtime contract. It does not execute the task, mutate `PROGRESS/`, decide completion, write runtime reports, or require the worker to return a typed protocol.

## Runtime Contract

The generated entry must support these three mechanisms:

- `mixmod` communication channel: smart brief -> cheap worker workspace edit -> runtime captured diff -> smart review.
- LangGraph-style execution: explicit phase, conditional route, checkpoint, resume summary.
- `dual/lg2` input discipline: user intent becomes goal, scope, next action, completion boundary, stop condition, and optional index.

## Output File

- Create a root-level `lg2NN.md`, incrementing from existing `lg2*.md`.
- Edit an existing entry only when the user names it.
- Do not require runtime input from chat history, raw logs, temporary notes, or external source prompts.

## Entry Shape

```md
# lg2 entry

## Goal
- terminal:
- current:

## Scope
Allowed:
- ...

Forbidden:
- ...

## Next Action
- ...

## Completion
- ...

## Stop
- ...

## Index
- ...
```

## Rules

- Keep one terminal goal.
- `Next Action` is the next executable workspace batch, not a roadmap.
- `Scope` defines what may be read, changed, or must not be touched.
- `Completion` is the smart review boundary: what final workspace state or artifact is enough for the runtime to accept the latest captured diff.
- `Stop` lists blockers the runtime must not resolve autonomously: missing input, scope expansion, destructive action, unavailable provider, external authority, or ambiguous completion.
- `Index` lists only stable project-owned markdown files that reduce repeated reading. Omit it when one entry is enough.
- Preserve the mixmod-style channel: the entry may guide brief content, diff review, and revision decisions, but it must not require worker JSON reports.
- Preserve LangGraph-style phases by making the next phase derivable from the entry plus `PROGRESS/state.json`.
- Do not include runtime schemas, provider internals, `PROGRESS/*`, stdout, stderr, chat history, or worker self-claims as source-of-truth requirements.

## Workflow

1. Classify the request as new entry or repair.
2. Inspect directly related files only when file or behavior boundaries affect the entry.
3. Remove duplicated background and historical wording.
4. Convert intent into the smallest entry that lets `./lg2` produce a brief, capture a diff, review that diff, resume from state, and stop on explicit blockers.
5. Reply with the entry path and unresolved blockers.
