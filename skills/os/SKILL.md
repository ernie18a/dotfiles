---
name: os
description: Manual invocation only
---

# Purpose

- Create the next unused `osNN.md` as an implementation manual.
- Transfer resolved decisions as instructions an executor can implement directly.
- The manual is not a report, architecture document, or rationale record.

# Author

- Read the user request, relevant code, and current `deve` skill.
- Apply these authoring rules directly; do not pass them to the executor.
- Use only explicit requirements and inspected code facts as authority.
- Inspect only until further facts cannot change instructions or decisions.
- Do not add, narrow, defer, or reinterpret requested behavior.
- After writing, do not check or validate the manual.

# Situational

- Identify material decisions in every task, regardless of its overall type.
- A decision is material when plausible alternatives could produce observably different required behavior, interfaces, data semantics, state transitions, failure behavior, side effects, or acceptance results.
- Resolve each material decision only from explicit requirements or inspected facts.
- If multiple outcome-changing choices remain plausible, do not write the manual; ask the user to resolve them.
- Do not treat implementation freedom as unresolved when all reasonable implementations preserve the same required outcome.
- Add detail only when its absence would force the executor to plan or guess.
- Split only when work can proceed independently without repeated context.

# Manual

- Make the manual sufficient for implementation without independent planning.
- State the exact target paths, changes, order, boundaries, and final behavior.
- State critical contracts, state transitions, and failure behavior when relevant.
- Preserve existing ownership and interfaces unless the requirement changes them.
- Group related changes by touched function, ordered from broad to narrow.
- Prefer replacement, deletion, and consolidation before adding new structure.
- Omit alternatives, rationale, repetition, and facts that do not guide execution.
- Do not require packets, graphs, maps, or formal sections without practical value.
- Prevent redesign, scope expansion, shortcuts, speculative work, and embellishment.
- Never reference prior `osNN.md` files or unstated conversation context.

# Executor

- End every manual with the following executor directive.
- `Implement exactly as written; do not replan, redesign, simplify, or add behavior.`
- `By default, run only lightweight, non-behavioral static checks; run other validation only when the user explicitly requests it.`
- `After editing, reply exactly DONE with no report.`

# Completion

- Before writing, verify that the executor can implement every requested behavior without selecting among materially different outcomes.
- Missing implementation detail is acceptable only when all reasonable implementations preserve the same required outcome.
- Write the manual only after every requested behavior has an executable instruction and every material decision is resolved.
- Reply exactly `DONE` after the `osNN.md` exists.
