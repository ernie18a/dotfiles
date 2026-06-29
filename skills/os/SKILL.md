---
name: os
description: Use when the user wants one osNN.md handoff for a downstream agent to execute without repeated clarification.
---

# os Handoff

Create one `osNN.md` for a downstream agent.

Before writing:

1. Read the user request, target project's governing instructions, existing status documents, and directly related code or documents. For file-using work, state only the file locations needed to execute or verify the task. Carry applicable constraints into Scope, Action, Verify, or Stop. The user request and governing instructions define the allowed work.
2. Identify any missing fact or choice that would change a Scope entry, a Phase's Action, or its Verify.
3. Resolve it using available evidence. If more than one valid direction remains, use the smallest option that satisfies the user's stated goal without adding unrequested work, then write the decision rule and boundaries the executor must follow; do not turn an unresolved choice into a fixed internal sequence.
4. Write only the result the executor needs to complete and verify the assigned work. Do not investigate anything else.

Keep one main goal. State the allowed and forbidden scope. Divide work into verifiable phases. Verify only what would decide acceptance of the work. Prefer one existing or minimal check that reaches the changed user-visible behavior or the original failure. Do not add new test scaffolding or broaden verification unless the existing checks cannot decide the result. Check a checkpoint after each completed phase.

Name handoffs incrementally: `os01.md`, `os02.md`.

## `osNN.md` Template

```md
# osNN

## Goal

- 最終要完成什麼。

## Scope

Allowed:
- 可改哪些檔案、模組或邊界。

Forbidden:
- 不可碰哪些範圍或改變哪些 contract。

## Phases

### Phase N: 名稱

Action:
- 需要完成什麼。

Verify:
- 方法：
- 預期：

## Completed checkpoints

- [ ] Phase N: 名稱

## Stop

- 下一步會超出 Scope 或違反 Contracts。
- 驗證失敗且無法在 Scope 內修正。

## Report

- completed work:
- verification:
- result:

```
