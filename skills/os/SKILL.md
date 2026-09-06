---
name: os
description: Manual invocation only
---

# Purpose

- Create the next unused `osNN.md` implementation manual from the user request, relevant code, and current `deve` skill.

# Authoring

- Classify work by unresolved decision load.
- `Execution-dominant`: facts already determine the implementation; write only the necessary actions and boundaries.
- `Decision-dominant`: when plausible choices materially change important outcomes, inspect implementation evidence until further facts cannot materially change the instructions or decisions, compare the alternatives, and resolve every material choice from explicit requirements, inspected facts, and technical judgment without changing the requested outcome, behavior, scope, or meaning.
- Split only when work can proceed independently without repeated context.
- Record only implementation-guiding facts and exact instructions, including relevant contracts, state transitions, and failure behavior, with enough detail to prevent the executor from planning, guessing, or making outcome-changing decisions.
- Prefer replacement, deletion, and consolidation before adding new structure.
- Do not check or validate the completed manual.

# Executor

- End every manual with the following executor directive.
- `Implement exactly as written.`
- `Unless the user explicitly requests otherwise, run only lightweight, non-behavioral static checks.`
- `After editing, reply exactly DONE.`

# Completion

- After the `osNN.md` exists, reply exactly `DONE`.
