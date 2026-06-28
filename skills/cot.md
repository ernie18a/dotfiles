---
name: focus-ideation
description: Guide broad but disciplined exploration across domains. Use when the task needs reframing, multiple distinct options, assumption checks, tradeoff analysis, and deliberate convergence without wasting effort on low-impact elaboration.
---

# Focus Ideation

Use this skill when the task benefits from reframing, exploration, comparison, or staged convergence rather than one immediate answer. Open enough space to surface materially different directions, then converge as soon as further expansion stops changing the decision.

Do not optimize for completeness. Optimize for decision value, distinction between options, and clear stopping.

## Premise Check

Before expanding the task, identify:

- the actual objective
- the judgment, decision, or action this work could change
- the operative constraints
- whether the next step needs breadth, depth, comparison, or selection

Correct weak framing before expanding it. If the prompt asks for "the best" too early, replace that with "what distinct approaches exist" unless the user already fixed the evaluation criteria.

## Workflow

### 1. Frame the space

Separate objective, constraints, assumptions, and evaluation criteria.

Remove accidental wording, stale examples, and precision that does not affect the outcome.

### 2. Expand deliberately

Generate clearly different directions first. Prefer differences that could materially change the later comparison or conclusion.

Avoid producing near-duplicates that only differ in phrasing or surface detail.

### 3. Reduce to viable branches

Discard weak variants quickly. Keep only branches that could lead to materially different conclusions, risks, actions, or interpretations.

For each surviving branch, state:

- what makes it distinct
- what advantage it offers
- what assumption it depends on

### 4. Evaluate by impact

Judge options by the factors that can actually change the recommendation. Derive those factors from the task instead of reusing a fixed rubric.

Do not spend effort polishing dimensions that would not change the choice. Merge options that are equivalent on decision-relevant factors.

### 5. Attack assumptions

For the strongest options, look for the assumptions, limits, and failure paths that could materially change the judgment.

Prefer a small number of strong disconfirming checks over long generic caution lists.

### 6. Converge on usable output

Stop when:

- the leading options are clearly differentiated
- the next round would mostly add variation, not change the judgment
- remaining uncertainty does not justify more expansion
- the user can act, choose, compare, or deepen one branch

Return the smallest output that supports the next decision.

## Output

Return only what the task needs. Usually include:

- the corrected framing
- the surviving options or branches
- the key tradeoffs
- the assumptions that matter
- the current recommendation, comparison, or next validation step

If further ideation would have low value, say so directly and stop.

## Boundaries

This skill guides reasoning behavior. It does not guarantee novelty, correctness, or control of hidden internal cognition.

Use it to structure exploration and convergence, not to claim that the model's inner process has been fully constrained.
