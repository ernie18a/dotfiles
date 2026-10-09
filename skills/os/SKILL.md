---
name: os
description: Manual invocation only
---


# Authoring

- Classify work by unresolved decision load.
- `Execution-dominant`: facts already determine the implementation; write only the necessary actions and boundaries.
- `Decision-dominant`: when plausible choices materially change important outcomes, inspect implementation evidence until further facts cannot materially change the instructions or decisions, compare the alternatives, and resolve every material choice from explicit requirements, inspected facts, and technical judgment without changing the requested outcome, behavior, scope, or meaning.
- Split only when work can proceed independently without repeated context.
- Write exact implementation instructions grounded in the conversation’s core purpose and relevant facts. Briefly connect the intended outcome to the current system, specifying the contracts, state transitions, failure behavior, and completion conditions needed for execution without further planning, guessing, or outcome-changing decisions.
- Prefer replacement, deletion, and consolidation before adding new structure.
- Do not check or validate the completed manual.

# Executor

- End every manual with the following executor directive.
- `Implement exactly as written.`
- `Run only lightweight, non-behavioral static checks.`
- `After editing, reply exactly DONE.`

# Completion

- After the `osNN.md` exists, reply exactly `DONE`.
