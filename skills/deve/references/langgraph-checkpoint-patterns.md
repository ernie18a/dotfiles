# LangGraph Checkpoint / Persist Placement

## Unconditional Persist Before First Provider Call

The first provider call (`planner.plan()`, `worker.work()`) can raise or get interrupted.
If no `state.json` was written before that call, the session has zero durable state and
cannot resume with minimal tokens (violates `r2.md` requirement).

**Rule**: persist unconditionally between `load_checkpoint` and the conditional router,
**not** on the conditional router itself.

### Correct (os04 fix)

```
START → load_checkpoint → persist_after_load → conditional_route → plan_batch
                                                          → verify_evidence
                                                          → persist_checkpoint
```

```python
builder.add_edge(START, "load_checkpoint")
builder.add_edge("load_checkpoint", "persist_after_load")
builder.add_conditional_edges(
    "persist_after_load",
    _route_after_load,
    {"plan": "plan_batch", "verify": "verify_evidence", ...},
)
```

### Wrong — persist after conditional

`load_checkpoint → conditional → (plan → persist / verify → persist ...)`

If `plan_batch` calls `planner.plan()` which raises, the `persist_after_plan` node
never runs. No `state.json` exists. Interruption = total loss.

### Wrong — persist inside conditional, before provider

Only works if **every** route calls persist first. Easy to miss when adding a new route.

## Implementation Pattern

Reuse an existing `_persist_intermediate` node:

```python
builder.add_node("persist_after_load", _persist_intermediate)
```

`_persist_intermediate` calls `save_state(runtime, Path(runtime.state_path))` and
returns `{}` (no state mutation, pure side-effect node).

The conditional router function stays on the same `next_route` key — just move the
`add_conditional_edges` call to the new persist node.

## Pitfall: Reuse Route

When `_route_after_load` returns `"reuse"`, the old code routed directly to
`persist_checkpoint`. After `persist_after_load`, the route is:

```
persist_after_load → persist_checkpoint → END
```

This is fine — `persist_after_load` already saved the initial state, and
`persist_checkpoint` saves the terminal receipt. Double-write is idempotent
(atomic replace via `.tmp` + `.replace()`).

## Worked-State Resume Pattern

When a worker completes (`status == "worked"`, `last_worker_report.done == true`)
but verification was never executed (`verification_result is None`), a fresh run
must route to `verify_evidence`, **not** re-plan from scratch.

### Route Decision in `_load_checkpoint`

```python
next_route = "plan"
if runtime.status in {"done", "complete"}:
    ...
elif runtime.status == "worked" and runtime.verification_result is None:
    # Worker completed but verification was never run → go to verify
    next_route = "verify"
elif runtime.last_audit_result == "auditing":
    # Audit was interrupted (crashed/timeout). Re-verify to re-trigger audit flow.
    next_route = "verify"
elif runtime.status == "failed" and runtime.last_worker_report and runtime.verification_result:
    # Verification-specific failure from old code that terminal-failed
    report_data = runtime.last_worker_report
    if isinstance(report_data, dict) and report_data.get("done"):
        vr = runtime.verification_result
        if isinstance(vr, dict) and vr.get("status") == "failed":
            runtime.status = "worked"
            next_route = "verify"
elif runtime.last_audit_result == "continue":
    next_route = "plan"
```

The `failed + done + verification.failed` branch recovers from old-style terminal
failures by resetting the status to `"worked"` so verification and recovery flows
can process the failure properly.

### Complete / Done Equivalence

A checkpoint with `status == "complete"` (set by planner audit returning
`StopDecision(status="complete")`) is treated as equivalent to `"done"` for
resume routing. Both are terminal states that should route to `verify` (if
re-audit or evidence changed) or `reuse` (if evidence unchanged).

### Auditing Checkpoint Resume

When `last_audit_result == "auditing"`, a crash/interruption occurred during
planner audit. Resume routes to `verify` which re-runs verification and then
re-enters the audit flow via `_audit_precheck`.

## Verification Failure Routing (not terminal failed)

When a verification command fails (non-zero returncode), the runtime should NOT
immediately set `runtime.status = "failed"` and terminal-stop. Instead, it should
record the failure in `verification_result` and let `_audit_precheck` route to
recovery/planner_audit where a planner can judge whether the failure is acceptable
per the entry's prose.

### `_verify_evidence` — Don't Terminal-Fail

```python
if result.returncode != 0:
    status = "failed"
    # Do NOT set runtime.status = "failed" here —
    # let _audit_precheck route verification failures to recovery/planner_audit
```

### `_audit_precheck` — Recovery for Verification Failures

When `verification_result.status == "failed"`, the precheck sees
`has_failed_verification = True` and the planner_audit condition fails
(`not has_failed_verification` is False), falling through to the recovery route:

```python
if report.done:
    has_failed_verification = verification.get("status") == "failed"

    # Route: re-audit of done/complete checkpoint with failed verification → terminal failure
    if runtime.status in {"done", "complete"} and has_failed_verification:
        runtime.status = "failed"
        runtime.stop_reason = "verification failed during re-audit"
        ...
        return {"runtime": ..., "next_route": "failed"}

    # Route: all evidence OK + planner available → planner_audit
    if not missing_evidence and (path_evidence or has_command_verification) and not has_failed_verification:
        return {"runtime": ..., "next_route": "planner_audit"}

    # Recoverable: missing evidence / no deterministic evidence / verification failed
    return {"runtime": ..., "next_route": "recovery"}
```

### Exception: Re-Audit of Done Checkpoint

If the checkpoint was `status in {"done", "complete"}` (a previous successful
completion) and re-audit's verification fails (evidence tampered), the failure
MUST be terminal. The guard catches this before the recovery route.

## Failed Checkpoint Resume Pattern

When a checkpoint has `status == "failed"` from old code that terminal-failed on
verification, the new code can recover by:

1. `_load_checkpoint` detects the pattern and resets to `"worked"`, routes to `"verify"`
2. `_verify_evidence` re-runs verification commands
3. If verification passes → normal flow through precheck → planner_audit
4. If verification fails again → recovery → planner decides

Condition in `_load_checkpoint`:
```python
elif runtime.status == "failed" and runtime.last_worker_report and runtime.verification_result:
    report_data = runtime.last_worker_report
    if isinstance(report_data, dict) and report_data.get("done"):
        vr = runtime.verification_result
        if isinstance(vr, dict) and vr.get("status") == "failed":
            runtime.status = "worked"
            next_route = "verify"
```

Only fires when BOTH `done == true` AND `verification_result.status == "failed"` —
a genuine terminal failure (planner crash, worker crash) without these conditions
will NOT be reset, preserving its failed state.

## Pre-Audit Checkpoint (Provider Failure Resilience)

Before calling `planner.audit()` in both `_recovery()` and `_planner_audit()`,
persist the current state with `last_audit_result = "auditing"`. This ensures
that a crash or schema timeout during the audit call leaves a recoverable
checkpoint instead of a blank-slate state.

```python
# In _recovery() and _planner_audit():
runtime.last_audit_result = "auditing"
save_state(runtime, Path(runtime.state_path))

try:
    decision = coerce_audit_result(
        planner.audit(_build_audit_context(runtime, bundle, report))
    )
except (ProviderError, ProviderExecutionError, ProviderProtocolError, ProviderConfigError) as exc:
    runtime.status = "blocked"
    runtime.stop_reason = f"audit provider failed: {exc}"
    runtime.last_audit_result = "blocked"
    _update_resume_summary(runtime, report.resume_summary, runtime.stop_reason)
    return {"runtime": runtime.to_dict(), "next_route": "blocked"}
```

On provider failure:
- Status becomes `"blocked"` (not `"failed"` — recoverable)
- `last_audit_result` is `"blocked"` (not empty — provides diagnostics)
- `stop_reason` contains the error summary (not raw traceback)
- Worker evidence and verification result are preserved (not reset)

On resume from `last_audit_result == "auditing"`:
- `_load_checkpoint` routes to `"verify"` (not `"plan"`)
- Graph re-runs verification and re-enters audit flow
- Worker is NOT re-executed (no new plan created)

## Graph Wiring for Verify Route

The `"verify"` route must be registered in the conditional edges from the
post-load persist node:

```python
builder.add_conditional_edges(
    "persist_after_load",
    _route_after_load,
    {"plan": "plan_batch", "reuse": "persist_checkpoint", "verify": "verify_evidence"},
)
```

The runtime graph's `_route_status` must normalize "complete" to "done":

```python
def _route_status(state: GraphState) -> str:
    route = state.get("next_route", "done")
    return "done" if route in {"reuse", "complete"} else route
```

And `_persist_checkpoint` must do the same normalization:

```python
def _persist_checkpoint(state: GraphState) -> dict[str, Any]:
    ...
    next_route = state.get("next_route", "done")
    if next_route in {"reuse", "complete"}:
        next_route = "done"
    return {"runtime": runtime.to_dict(), "next_route": next_route}
```

The `"plan"`, `"done"`, `"blocked"`, `"failed"` keys must all be in the
`add_conditional_edges` mapping from `persist_checkpoint`.

## Why This Matters

Without the resume and recovery patterns:
- A worker that finished hard work but was interrupted before verification runs
  gets **re-planned and re-executed** — wasting provider tokens and risking
  duplicate writes.
- A verification failure that is acceptable per entry prose goes directly to
  terminal-failed without giving the planner a chance to judge.
- An audit provider crash (schema error, timeout) leaves no durable trace,
  making the next run start from scratch.

## Regression Test Patterns

```python
def test_runtime_worked_resume_routes_to_verify(tmp_path: Path) -> None:
    first = Runtime(...).run()
    assert first.status == "done"
    state = json.loads((tmp_path / "PROGRESS" / "state.json").read_text())
    state["status"] = "worked"
    state["verification_result"] = None
    state["last_audit_result"] = ""
    state_path.write_text(json.dumps(state), encoding="utf-8")
    planner.plan_calls = 0
    second = Runtime(...).run()
    assert second.status == "done"
    assert planner.plan_calls == 0
    assert state_after["verification_result"]["status"] == "passed"

def test_regression_verification_failure_routes_to_recovery(tmp_path: Path) -> None:
    _write_entry(tmp_path, 'bash -lc "exit 1"')
    (tmp_path / "output.txt").write_text("hello world", encoding="utf-8")
    planner = RecoveryPlanner()
    worker = RecoveryWorker()
    result = Runtime(...).run()
    assert result.status == "done"
    assert planner.audit_calls > 0
    assert state["verification_result"]["status"] == "failed"
    assert state["verification_result"]["tests"][0]["returncode"] == 1

def test_regression_failed_checkpoint_verification_resumes_to_recovery(tmp_path: Path) -> None:
    first = Runtime(...).run()
    assert first.status == "done"
    state = json.loads(state_path.read_text())
    state["status"] = "failed"
    state["verification_result"] = {"status": "failed", "tests": []}
    state["stop_reason"] = "verification failed: old code terminal failure"
    state_path.write_text(json.dumps(state), encoding="utf-8")
    resume_planner = FakePlanner()
    resume_worker = RecoveryWorker()
    second = Runtime(...).run()
    assert second.status == "done"
    assert resume_planner.plan_calls == 0
    assert resume_planner.audit_calls >= 1
    assert resume_worker.calls == 0

def test_regression_audit_provider_failure_persists_checkpoint(tmp_path: Path) -> None:
    _write_entry(tmp_path, 'python -c "..."')
    (tmp_path / "output.txt").write_text("hello world", encoding="utf-8")
    class FailingAuditPlanner:
        def audit(self, context): raise ProviderExecutionError("codex exec failed")
    planner = FailingAuditPlanner()
    worker = FakeWorker()
    result = Runtime(...).run()
    assert result.status == "blocked"
    assert "audit provider failed" in result.summary
    state = json.loads((tmp_path / "PROGRESS" / "state.json").read_text())
    assert state["status"] == "blocked"
    assert state["last_audit_result"] == "blocked"
    assert state["last_worker_report"]["done"] is True
    assert planner.plan_calls == 1
    assert worker.calls == 1

def test_regression_auditing_checkpoint_resumes_without_replan(tmp_path: Path) -> None:
    first = Runtime(...).run()
    assert first.status == "done"
    state = json.loads(state_path.read_text())
    state["last_audit_result"] = "auditing"
    state_path.write_text(json.dumps(state), encoding="utf-8")
    resume_planner = FakePlanner()
    resume_worker = RecoveryWorker()
    second = Runtime(...).run()
    assert second.status == "done"
    assert resume_planner.plan_calls == 0
    assert resume_planner.audit_calls >= 1
    assert resume_worker.calls == 0
```
