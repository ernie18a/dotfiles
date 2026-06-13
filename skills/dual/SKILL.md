---
name: dual
description: "Prepare INPUT/*.md briefs for the /g/app/dual dual-session Codex orchestrator. Use when Codex should turn a user goal, repo state, unresolved issue, or handoff notes into low-coupling input files that let a smart Codex guide a worker Codex with structured progress, supervision, escalation rules, verification boundaries, and minimal manual switching."
---

# Dual

## Purpose

Create input documents for `/g/app/dual`.

The tool is the runtime:

- start smart and worker Codex sessions
- pass prompts between them
- require structured replies
- persist state and transcript
- apply generic runtime guardrails

This skill is the strategy layer:

- write `INPUT/*.md`
- define task goal, scope, validation, stop rules, and escalation policy
- keep task semantics out of the tool
- make smart Codex lead worker Codex without requiring the user to manually switch models

## Output

Create one or more markdown files intended to be placed under a target project's `INPUT/`.

Default:

```text
INPUT/00-brief.md
```

Use multiple files only when it improves sorting and reuse:

```text
INPUT/00-brief.md
INPUT/10-context.md
INPUT/20-policy.md
```

Do not create tool-specific code unless the user explicitly asks to modify `/g/app/dual`.

## Source Handling

Accept the user's named source material as the root of truth for the generated brief. The source may be an existing handoff file, project note, issue, repo state summary, chat instruction, or a combination of these.

Convert source material into the `INPUT/*.md` contract instead of assuming the source already has that shape. Preserve source path semantics: if the root material says to read `STATUS.md`, keep it as `STATUS.md` unless it explicitly names `INPUT/STATUS.md`.

When source material contains a local workflow such as "read this first, then read that only if needed", translate it into scope and context rules for Smart/Worker. Do not flatten it into an instruction to read every referenced file up front.

## Fit Check

Before writing input files, verify the premise:

- The goal needs smart planning plus cheaper worker execution.
- The task can be described with clear scope and stop conditions.
- Worker can make progress from a batch plan without reading chat history.
- Any required repo context can be named directly.

If the task is a direct one-shot fix, say that `/g/app/dual` may add overhead and produce a smaller direct handoff instead.

## File Requirements

Each generated input set must be self-contained enough for smart Codex to start.

Include:

- goal
- current state or known issue
- allowed scope
- forbidden scope
- contracts that must not change
- verification commands or verification limits
- escalation policy
- completion criteria
- reporting expectations

Avoid:

- chat history dumps
- long architecture essays
- tool implementation details
- duplicate runtime rules already owned by `/g/app/dual`
- instructions that require the tool to understand project-specific semantics

## Boundary Rules

Put in the input documents:

- task slicing
- issue equivalence rules
- when worker may retry
- when smart must shrink scope
- when smart must stop delegating and directly handle the issue
- when human input is required
- project-specific command restrictions

Do not put in the input documents as requirements on the tool:

- state file format
- transcript file format
- JSON parser behavior
- turn counter behavior
- runtime exception retry policy
- MCP protocol handling

Mention tool behavior only as an assumption when needed.

## Minimal Template

Use this shape unless the user provides a stronger format:

```md
# dual input

## Goal

- ...

## Current State

- ...

## Scope

Allowed:
- ...

Forbidden:
- ...

## Contracts

- input:
- output:
- error:
- invariants:

## Verification

- allowed commands:
- forbidden commands:
- expected evidence:

## Escalation Policy

- If worker reports `done`, smart reviews the report and either issues the next batch or stops with `done`.
- If worker reports `blocked` on a local implementation issue, smart should first shrink or clarify the batch.
- If the same issue remains blocked after one revised batch, smart should stop delegating that issue and handle the decision directly.
- If the next action would violate Scope, Contracts, or command restrictions, smart should return a `blocked` stop decision.
- Runtime failures, malformed JSON, or tool protocol failures are owned by `/g/app/dual`, not by this policy.

## Completion Criteria

- ...

## Report Expectations

- changed files:
- tests:
- unresolved issue:
- assumptions:
```

## Escalation Guidance

Keep escalation semantic and task-local.

Good:

```text
Treat the issue as the same issue only when the failing command, failing behavior, and touched module are unchanged.
```

Bad:

```text
The tool should count three worker failures and then force smart to code.
```

The tool cannot reliably know whether two implementation failures are the same task issue. Smart Codex can judge that from the worker report and repo context.

## Cross-Project Use

Assume `/g/app/dual` is run from the target project directory:

```bash
uv run --project /g/app/dual --directory "$PWD" python -m dual
```

## Path Semantics

Generated input files live under `INPUT/`, but project paths mentioned inside them are relative to the target project root, not to `INPUT/` and not to `/g/app/dual`.

Use `INPUT/...` only for files that are themselves task inputs. Use root-relative paths such as `STATUS.md`, `src/foo.rs`, or `tests/foo.rs` for project context and implementation files.

If a referenced project file may not exist, keep that as an uncertainty in the brief instead of rewriting the path.

## Quality Bar

Prefer the smallest useful input set.

Remove anything that does not affect:

- smart planning
- worker execution
- validation
- stopping
- escalation

When in doubt, write less and make boundaries sharper.
