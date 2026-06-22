---
name: single
description: Use when the user wants one runNN.md handoff for a downstream agent to execute without repeated clarification.
---

# Single-Pass Handoff

Create one `runNN.md` for a downstream agent.

Before writing:

1. Read the user request, target project's governing instructions, existing status documents, and directly related code or documents. The user request and governing instructions define the allowed work.
2. Identify any missing fact or choice that would change a Scope entry, a Phase's Change, or its Test.
3. Resolve it using available evidence. If more than one valid direction remains, choose the one that best meets the user's stated goal without adding unrequested work.
4. Write only the result the executor needs to make a change or run a test. Do not investigate anything else.

Keep one main goal. State the allowed and forbidden scope. Divide work into testable phases. Check a checkpoint after each completed phase.

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
