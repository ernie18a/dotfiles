# Dual Runtime: DeepSeek Provider & No-Progress Quirks

## `response_format: json_object` + tools suppresses tool calling

**Problem**: When both `tools` and `response_format: {"type": "json_object"}` are sent in the same DeepSeek API call, the model skips tool calls entirely and fabricates a direct JSON response instead. The model claims to have called `list_files('.')` and got back only the entry markdown file, when in fact no tool was ever executed.

**Root cause**: `json_object` response format instructs the model to produce valid JSON directly. Combined with tools, the model chooses the JSON path (which satisfies the format constraint) over the tool-calling path. The tool loop iterates, but the model never produces a `tool_calls` response.

**Fix**: Remove `response_format: {"type": "json_object"}` from the tool loop payload in `_run_tool_loop`. The worker prompt already instructs the model to return JSON (OUTPUT CONTRACT), and the tool-calling protocol naturally produces structured output. Only the final non-tool response needs to be parseable JSON.

**Location**: `providers.py:DeepSeekProvider._run_tool_loop()` — the payload dict that includes `"tools": tools` must not include `"response_format": {"type": "json_object"}`.

**Affected**: DeepSeek provider only. Codex and Agy providers don't use this API pattern.

---

## Worker prompt lacks workspace context — worker fabricates "empty workspace"

**Problem**: The worker prompt only includes `BRIEF_FILES` listing the entry markdown filenames (e.g., `["02.md"]`). The model sees no evidence of other workspace files and may infer the workspace is empty or contains only the entry file. With `json_object` suppressing tool calls, the model can't discover the real workspace via `list_files`.

**Fix**: Add `OBSERVED_FILES` to the worker prompt — a dump of `snapshot_files(self.cwd).keys()` — so the model sees the actual workspace contents directly. Also add a `WORKSPACE:` guidance line telling the worker it has tools and should not assume the workspace is limited to `BRIEF_FILES`.

**Location**: `runtime.py:Orchestrator._worker_prompt()` — add `OBSERVED_FILES` and `WORKSPACE` guidance after `BRIEF_FILES`.

**This is what _planner_prompt already does** in review mode — the planner gets `OBSERVED_FILES` via `snapshot_files(self.cwd)`. The worker prompt was missing this same context.

---

## `_finish()` returns stale `last_confirmed_report` changed_files

**Problem**: When a run fails (e.g., no-progress), `_finish()` reads `changed_files` from `last_confirmed_report` (the previous successful run) and returns them in `RunResult`. The CLI prints these as `changed: src/cli.rs, changed: STATUS.md`, misleading the user into thinking those files changed in the failed run.

**Fix**: Return `changed_files` from `last_worker_report` (the current run's report) when it has non-empty changes. Fall back to `last_confirmed_report` only on `DONE` status (where the confirmed report represents the accumulated changes).

**Location**: `runtime.py:Orchestrator._finish()` — logic:
1. If `last_worker_report.changed_files` is non-empty → return those.
2. Elif status is `DONE` → fall back to `last_confirmed_report.changed_files`.
3. Else → return empty `()`.

---

## No-progress guard must not count `blocked` worker reports

**Problem**: The no-progress guard at lines 308-316 of `runtime.py` increments `no_progress_count` when `actual_changed` is empty (branch `elif not actual_changed`). A `blocked` worker report legitimately has no file changes, but that's expected — the worker discovered a blocker, not "no progress." Blocked reports are a valid terminal state that the planner can accept via `stop_decision`.

**Fix**: Wrap the no-progress check inside `if report.status != RunStatus.BLOCKED:`. Blocked reports skip the increment entirely, leaving no_progress_count at 0. Only `done` or `failed` statuses with no actual changes trigger the guard.

**Location**: `runtime.py:Orchestrator.run()` — the no-progress check block after `_call_worker_with_snapshot()`.

**Why MAX_NO_PROGRESS_RETRIES = 1 works now**: It catches only genuine conflicts — a worker that claims `done` or `failed` with no file changes twice in a row. A blocked worker that stays blocked across multiple planner retries is handled by the planner's escalation policy, not the runtime's no-progress guard.
