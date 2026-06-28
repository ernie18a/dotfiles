---
name: first-margin
description: Use when deciding what to build, adopt, keep, cut, prioritize, or recommend under limited attention, time, context, money, or implementation capacity. Applies first-principles reasoning and marginal-return triage so Codex selects only inputs, tools, features, options, research paths, or process steps whose next unit of effort is still in the increasing-marginal-return region; isolates helpful-but-low-leverage additions instead of accumulating them.
---

# First Margin

## Overview

Choose by first principles and marginal return, not by whether an option is merely helpful. Preserve only the next actions or additions whose incremental effect compounds the objective; isolate options whose benefit is positive but already tapering.

## Premise Check

Before recommending or implementing additions, identify:

- The real objective, stated as the outcome to improve.
- The bottleneck that currently limits the objective.
- The smallest next input that could remove or weaken that bottleneck.
- The scarce resource being spent: attention, time, complexity, money, latency, risk, context, maintenance, or user effort.

If the objective or bottleneck is unclear, do not rank many options as if they were comparable. State the missing premise and choose the minimum reversible probe when action is still needed.

## Marginal-Return Filter

Classify each candidate by the next unit of investment, not by total theoretical value:

- `Increasing`: The next unit unlocks more capability than the previous unit, removes a primary bottleneck, simplifies future work, or compounds learning. Prefer these.
- `Diminishing`: The next unit is still useful but mostly adds coverage, polish, optionality, redundancy, or convenience. Defer or isolate unless it is required for correctness, safety, or a hard external constraint.
- `Zero`: The next unit does not change the decision, implementation path, user outcome, or risk profile. Cut.
- `Negative`: The next unit increases confusion, maintenance, latency, coordination cost, surface area, or decision paralysis more than it helps. Reject or remove.

Do not equate "positive value" with "should include." A positive-but-diminishing option must lose to an increasing-return option when resources are scarce.

## Selection Rules

Use these rules in order:

1. Reduce the problem to first principles: objective, bottleneck, constraint, next input.
2. Prefer the smallest option that changes the bottleneck curve, not the largest option set.
3. Keep options in the `Increasing` region until the next addition would become merely incremental.
4. Quarantine `Diminishing` options into a backlog, optional note, or explicit later phase; do not mix them into the core recommendation.
5. Stop adding when the next option mainly increases choice count, explanation cost, implementation surface, or maintenance burden.
6. Override the filter only for correctness, safety, legal compliance, data loss prevention, security, or an explicit user requirement.

## Output Discipline

When this skill affects the answer or implementation, make the prioritization visible:

- State the first-principles objective in one sentence when it is not already obvious.
- Name the selected `Increasing` options and why they compound or unlock the bottleneck.
- Put `Diminishing` options under a short "Deferred" or "Isolated" note only when useful for user judgment.
- Do not enumerate every rejected option unless the user asked for a comparison.
- Prefer a small executable next step over a broad menu.

## Development Use

When writing or changing code:

- Build the narrow change that removes the current blocker before adding adjacent features.
- Avoid adding configuration, abstractions, dependencies, hooks, flags, or UI states merely because they may help later.
- Treat optional extensibility as `Diminishing` until a concrete near-term caller exists.
- Prefer deletion, replacement, or consolidation before addition when maintaining prompts, specs, policies, or skills.
