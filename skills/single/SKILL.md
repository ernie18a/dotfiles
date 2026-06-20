---
name: single
description: Use when the user wants one runNN.md handoff for a downstream agent to execute without repeated clarification.
---

# Single-Pass Handoff

Create one `runNN.md` for a downstream agent.

Before writing, read the user request, existing status documents, and directly related code or documents. Use only explicit task requirements and the target project's governing instructions.

Keep one main goal. State the allowed and forbidden scope. Add contracts or decision rules only when the task has a real interface or ambiguity. Divide work into testable phases. Check a checkpoint after each completed phase.

Name handoffs incrementally: `run01.md`, `run02.md`.

## `runNN.md` Template

```md
# runNN

## Goal

- 最終要完成什麼。

## Scope

Allowed:
- 可改哪些檔案、模組或邊界。

Forbidden:
- 不可碰哪些範圍或改變哪些 contract。

## Phases

### Phase N: 名稱

Change:
- 需要改什麼。

Test:
- command:
- expected:

## Completed checkpoints

- [ ] Phase N: 名稱

## Stop

- 下一步會超出 Scope 或違反 Contracts。
- 測試失敗且無法在 Scope 內修正。

## Report

- changed files:
- tests:
- result:
```
