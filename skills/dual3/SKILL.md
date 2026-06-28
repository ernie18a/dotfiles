---
name: dual3
description: Create concise, audit-driven root-level dualNN.md briefs for /g/app/dual. Use when Codex must prepare a planner-worker task contract that helps the runtime choose batches, reject false completion, preserve high-risk boundaries, and verify terminal success across varied projects without carrying chat history.
---

# Dual3

Create root-level `dualNN.md` entry briefs for `/g/app/dual`.

Write for the runtime's actual readers:
- The planner reads the full brief to choose the next `batch_plan`.
- The worker receives only the active plan, not the whole brief.
- The terminal audit rereads the brief to decide whether the terminal goal and all Completion Criteria are satisfied.

The brief is not an archive, status report, or complete requirements dump. It is a compact planner/audit contract.

## Preflight

Inspect only inputs that can change the contract:
- the target project root and applicable project instructions
- existing `dualNN.md`, `STATUS.md`, or indexed context files when present
- files, logs, commands, or notes needed to define scope, boundaries, verification, or completion

If the task is a direct one-shot fix that does not benefit from planner-worker execution, say `/g/app/dual` is likely overhead and provide a smaller handoff instead.

Do not ask for choices when the worker can inspect, derive, acquire, or implement the smallest in-scope path.

## Boundary First

Before writing sections, identify the smallest set of high-value failure boundaries. Prefer three; use at most five unless more are independently necessary for terminal correctness.

A boundary is high value only if it prevents one of these failures:
- the planner declares a partial batch as terminal success
- the worker changes the wrong files or violates a non-negotiable contract
- verification passes while the real product behavior is still wrong
- stale, mocked, cached, or pre-existing evidence is counted as fresh success
- an external blocker is hidden as done or expanded into unrelated work

Merge or delete low-value boundaries before writing the brief. Do not include a section, constraint, test, or example unless it protects a listed boundary or lets the planner choose the next batch.

## Default Brief Shape

Use this shape by default:

```md
# task brief

## Goal

- terminal:
- current batch:

## Boundaries

- ...

## Verification

- ...

## Completion Criteria

- terminal success:
- required evidence:
- not sufficient:
```

Add other sections only when they materially improve planner batch selection or terminal audit:
- `Current State`: only facts that change the next plan.
- `Progress`: only durable completed work across batches.
- `Context Index`: only stable project-owned references the planner may need later.
- `Scope`: when file/module/action boundaries are too detailed for `Boundaries`.
- `Contracts`: when API, data, CLI, output, or compatibility invariants need their own oracle.
- `Escalation`: only task-specific blocker rules not already covered by runtime autonomy.
- `Handoff State`: only when worker reports need task-specific evidence fields beyond the runtime schema.

Do not fill a section because a template contains it.

## Verification Discipline

Verification must target the highest-risk false-pass paths.

Keep a verification item only when failing production behavior would make it fail. Reject checks that only prove names, files, enum variants, config text, generated artifacts, or mock-only behavior exist.

When the task depends on evidence freshness, define how stale, cached, pre-existing, or unrelated outputs are excluded.

When real external systems can block completion, require bounded attempts with observed evidence and a clear blocker. Do not let the blocker replace deterministic in-scope verification.

## Completion Criteria

Treat `Completion Criteria` as the audit oracle. It must be short, observable, and hard to satisfy accidentally.

Include:
- terminal success conditions
- required evidence that proves those conditions
- conditions that are explicitly not sufficient

Use "not sufficient" to block common false completions, such as tests passing while production behavior is unwired, documentation changing while behavior is unchanged, or outputs existing before the current run.

## Output Rules

Write one root-level `dualNN.md` in the target project unless multiple entry files clearly reduce prompt size or support reusable independent batches.

Keep paths relative to the target project root.

Do not include:
- chat history, raw logs, source-file copies, or background narrative
- runtime protocol schemas or provider implementation details
- `PROGRESS/*`, `worker_report.json`, or runtime debug artifacts as source-of-truth files
- temporary approval, sandbox, or chat-session limits as product restrictions
- examples that stand in for a general decision rule

The final brief must still be executable if the original notes or chat context disappear.
