---
name: single
description: Use when the user wants a one-pass handoff plan for a less capable AI agent that creates a runNN.md file defining scope, contracts, phases, tests, stop conditions, and reporting so the downstream agent can execute a complete batch without repeated clarification.
---

# Single-Pass Handoff

## Objective

Create one `runNN.md` handoff file for a downstream agent.

The downstream agent should only need to run:

```text
follow runNN.md
```

The handoff must include enough scope, contracts, and decision rules for the downstream agent to complete a coherent batch without clarification loops.

## Responsibility Split

The planning agent decides:

- Whether the task premise is valid.
- The correct architecture direction.
- Which decisions must not be delegated.
- Which files, modules, and I/O boundaries are in scope.
- Which contracts must not change.
- Which execution order is required.
- Which tests allow progress.
- Which failures require stopping.
- How likely ambiguity should be resolved.
- Which changes would turn the task into a different task.

The downstream agent performs:

- Local implementation.
- Specified tests.
- Explicit local fixes.
- Local judgment using the handoff's scope, contracts, and decision rules.
- Structured status reporting.

The downstream agent must not:

- Re-scope the task.
- Change architecture direction.
- Expand requirements.
- Add new subsystems.
- Treat uncertainty as confirmed fact.

## Planning Standard

Use the smallest executable plan with explicit boundaries.

Plan only the parts where the downstream agent is likely to make bad decisions:

- Goal.
- Scope.
- Order.
- Contracts.
- Decision rules.
- Test ladder.
- Stop conditions.
- Report format.

Do not predesign unnecessary implementation detail:

- Do not write detailed internal function logic.
- Do not predict every possible error.
- Do not add broad background.
- Do not add generic risk lists.

## Fit

Use this skill when:

- The user wants a single handoff.
- The downstream agent can do most implementation.
- Cost matters more than maximum stability.

Choose one run type:

- Implementation run: goal, scope, contracts, and tests are clear enough to change files.
- Evaluation run: requirements, contracts, architecture, or tests need discovery before file changes.

Do not ask which run type to use. Pick the smallest run that preserves the user's stated goal and contracts.

## Handoff File Naming

Use incremental names that keep filesystem sorting stable:

```text
run01.md
run02.md
run03.md
```

Each `runNN.md` is one handoff.

## Required Context

Before writing `runNN.md`, read only the necessary context:

- User request.
- Existing status documents, if present.
- Directly related code or documents.

Do not read:

- Full history by default.
- Full codebase by default.
- Unrelated document chains.

## Run Size

Each run should have a single main goal, clear module boundaries, and phase-level checks.

Shrink the run when:

- Requirements are unclear.
- Architecture exploration is needed.
- The task touches data format, persistence, concurrency, permissions, or external I/O.
- Test method is unclear.

Allow a larger run when:

- Changes are mechanical and repetitive.
- Contracts are explicit.
- Test commands are stable.
- File and module boundaries are clear.

## `runNN.md` Template

```md
# runNN

## Goal

- 最終要完成什麼。

## Scope

Allowed:
- 可改哪些檔案、模組或邊界。

Forbidden:
- 不可碰哪些範圍。
- 不可新增哪些設計。
- 不可改變哪些 contract。

## Contracts

- input:
- output:
- error:
- invariants:

## Decision Rules

- ambiguity:
- default choice:
- evaluation criteria:
- assumption logging:

## Phases

### Phase 1: 名稱

Goal:
- 本階段完成什麼。

Change:
- 需要改什麼層級的東西。

Test:
- command:
- expected:

### Phase 2: 名稱

Goal:
- 本階段完成什麼。

Change:
- 需要改什麼層級的東西。

Test:
- command:
- expected:

## Failure loop

- 每階段測試失敗後，只修明確局部問題。
- 錯誤變少、位置改變、或通過更多測試，可以繼續修。
- 同一測試、同一錯誤、同一位置重複出現，停止。
- 修復造成 scope 外問題，停止。
- 需求、架構、跨模組資料流需要判斷時，依 Scope、Contracts、既有模式做最小可逆決策，並記錄 assumption。
- 只有所有可行決策都會違反 Scope 或 Contracts 時，停止。
- 修復開始變成猜測或擴 scope，停止。

## Stop

立即停止並回報：

- scope 不足，且無法縮小成 evaluation run。
- contract 衝突。
- 測試命令不存在或無法判斷結果。
- 同一錯誤重複。
- 所有可行下一步都會改變 Goal、越過 Scope、或違反 Contracts。

## Report

完成時回報：

- changed files:
- phases completed:
- tests:
- result:

停止時回報：

- stopped phase:
- failed command:
- key error:
- files changed:
- fixes tried:
```
