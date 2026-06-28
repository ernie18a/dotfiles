---
name: lg
description: Compile, repair, or tighten user requests into concise LangGraph runtime entry markdown for lg-run entry-file workflows. Use when the user wants to prepare work for the future LangGraph runtime, convert natural-language requirements into a robust entry contract, update an existing entry after clarification or runtime feedback, or discuss the skill/runtime boundary for this tool.
---

# LG

## Role

Prepare stable input for the LangGraph runtime. Treat the skill as a demand compiler, not as the runtime.

The skill may create or edit entry markdown. It must not execute worker tasks, mutate `PROGRESS/state.json`, decide terminal completion, or treat model claims, stdout, chat history, `STATUS.md`, or `CONTEXT/*` as canonical state.

## Boundary

`lg` owns input quality:
- Convert user intent into a short entry contract.
- Preserve only requirements that affect execution, safety, verification, or recovery.
- Identify missing goal, scope, evidence, stop condition, or next action.
- Repair an entry when runtime feedback shows ambiguity, missing evidence, or blocker context.

`lg-run` owns execution:
- Load entry markdown and compute its digest.
- Create or resume `PROGRESS/state.json`.
- Run graph nodes, worker actions, planner escalation, and verification.
- Decide `running`, `blocked`, `failed`, or `done` from checkpoint and observable evidence.

## Entry Contract

Use the smallest entry that can be executed and resumed safely:

```md
# LG Entry

## Goal
- ...

## Scope
Allowed:
- ...

Forbidden:
- ...

## Inputs
- ...

## Next Action
- ...

## Evidence Required
- ...

## Verification
- ...

## Stop
- ...

## Handoff
- ...
```

Rules:
- Keep one primary goal per entry.
- Keep `Next Action` to the next smallest executable workspace action.
- Make `Evidence Required` observable through file/content changes, command results, or explicit external input.
- Use `Verification` for concrete commands or deterministic evidence rules. If none is known, state the missing verification instead of inventing one.
- Use `Handoff` only when the next run cannot continue from the other fields. Keep it short.
- Split large work into an index entry plus referenced sub-entries instead of growing one file.

## Workflow

1. Check the premise.
   Confirm whether the request is for a new entry, an edit to an existing entry, a repair after runtime feedback, or a boundary/design discussion.

2. Remove noise before adding structure.
   Do not preserve chat phrasing, historical explanation, duplicate constraints, or implementation guesses unless they affect execution or verification.

3. Compile or repair the entry.
   Fill only the contract fields needed for safe execution. If critical information is missing, write it as an explicit blocker or open question.

4. Preserve runtime authority.
   Never mark the task done. Never claim that verification passed unless the runtime or user provides actual evidence.

5. Give the next command when useful.
   Prefer `lg-run <entry.md>` or the project-specific wrapper once it exists.

## Repair Rules

When runtime feedback says `blocked`, `failed`, or no progress:
- If the blocker is missing input or authority, update `Stop` or ask for the missing input.
- If the blocker is ambiguity, narrow `Goal`, `Scope`, or `Next Action`.
- If evidence is missing, add `Evidence Required` or `Verification`; do not weaken completion criteria.
- If the worker attempted broad or unsafe work, reduce `Next Action` and tighten `Forbidden`.
- If the entry digest changed intentionally, note that the runtime should re-audit or start fresh according to its checkpoint contract.

## Output Discipline

When editing an entry, report only:
- what changed
- what was removed or tightened
- what remains blocked or unverifiable
- the command to run, if execution is the next step

Prefer concise Traditional Chinese when replying to the user unless the edited artifact is already in another language.
