---
name: manual-min
description: Manual invocation only
---

# Manual-Min

Create a token-efficient execution manual for a lower-cost model or worker.

The expensive model must spend tokens only on decisions that reduce downstream ambiguity, rework, or failure risk.

## 1. Premise Check

Before writing the manual, identify:

- Goal: the user-visible outcome
- Executor: what the lower-cost model is expected to do
- Non-delegable judgment: decisions the executor should not infer
- Verification: how success or failure will be checked
- Stop condition: when the executor must stop and report

If the task cannot be verified from outputs, logs, tests, diffs, or explicit criteria, do not create a full manual. Ask for the missing boundary or return the blocker.

## 2. Value Filter

Include an instruction only if removing it would likely change one of these:

- executor action
- output shape
- correctness check
- failure handling
- user-facing result
- cost, risk, or rework

Delete instructions that only add professionalism, style, completeness, or theoretical coverage without changing execution.

## 3. Expensive Model Responsibilities

The expensive model should decide only:

- what must be done
- what must not be done
- what can be delegated
- what must be verified
- where execution must stop
- which assumptions are allowed

Do not make the expensive model enumerate every possible edge case unless the edge case changes the action or verification.

## 4. Executor Manual Contract

Write the manual in this structure:

### Objective

One sentence stating the required outcome.

### Inputs

Only the files, data, context, or assumptions required to start.

### Constraints

Only rules that change execution or prevent invalid output.

### Steps

Each step must contain:

1. Action:
2. Output:
3. Check:
4. Stop if:

### Final Verification

List the smallest checks that prove the task is complete.

### Return Format

Specify exactly what the executor must return.

## 5. Anti-Overbuild Rules

Do not add:

- background explanation
- motivational language
- broad best practices
- optional architecture
- speculative future requirements
- duplicated constraints
- examples that do not change behavior
- branches for unlikely cases
- quality adjectives without observable checks

Use a branch only when different conditions require different actions.

Use a checklist only when missing an item causes failure.

Use a schema only when the output will be parsed, compared, or reused.

Use detailed recovery only when failure is likely and recoverable.

## 6. Marginal Utility Test

For every section, ask:

- What failure does this prevent?
- Can the executor act without it?
- Can verification catch this cheaper than instruction can prevent it?
- Does this belong in the current task or a future task?

Remove the section if it does not change execution, verification, or failure handling.

## 7. Compression Rule

Prefer:

- one rule over repeated reminders
- concrete stop conditions over warnings
- output contracts over explanations
- verification checks over style guidance
- local assumptions over global architecture

The manual is complete when adding another instruction would not materially reduce ambiguity, rework, or risk.

## 8. Output

Return only:

1. Execution manual
2. Assumptions
3. Stop conditions
4. Verification checks

Do not include hidden reasoning, design justification, or unused alternatives.
