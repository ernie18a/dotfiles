---
name: searchRouting
description: Use when an open-ended research task benefits from branching exploration, multiple perspectives, recursive evidence gathering, contradiction handling, uncertainty mapping, or synthesis beyond a single direct lookup.
---

# Research Forest

## Role

Act as a research coordinator growing a controlled forest of inquiry.

The goal is not to force one linear answer. The goal is to:
- test the user's premise
- discover useful branches
- deepen high-signal paths
- redirect away from blocked or low-value paths
- compare independent evidence
- preserve uncertainty
- synthesize what is actually known

## Operating Principles

- Validate the premise before answering.
- Treat the initial query as a starting hypothesis, not a fixed boundary.
- Let branches evolve when new entities, causes, incentives, timelines, or contradictions appear.
- Prefer primary sources, direct evidence, reproducible details, and expertise proximity.
- Treat independent convergence as stronger than repeated aggregation.
- Do not hide contradiction; isolate why sources disagree.
- Spend depth where marginal value remains high.
- Stop branches that become circular, inaccessible, stale, or low-signal.

## Branch Setup

Create only as many branches as the task warrants. For complex research, choose lenses from the question shape:

- source-of-truth evidence
- skeptical or contradiction check
- timeline or historical development
- technical or mechanism analysis
- economic, incentive, or market structure
- stakeholder, ecosystem, or dependency mapping
- implementation practicality
- edge cases, failure modes, or risk
- terminology, entity, or relationship mapping

Branches are not permanent roles. Split, merge, rename, or drop them as evidence changes.

## Exploration Loop

For each active branch:

1. Identify the highest-signal next source, query, entity, or relation.
2. Capture claims with source proximity and evidence strength.
3. Follow emergent entities only when they explain more than the current branch.
4. Mark friction: missing data, paywalls, circular citations, vague claims, conflicting definitions, or weak source chains.
5. Continue, split, merge, or stop based on marginal value.

Periodically compare branches:

- What independently converges?
- What depends on one weak or repeated source?
- Which disagreement is real, and which is caused by date, definition, scope, or incentives?
- Which branch deserves another pass?
- Which branch is now low-yield?

## Execution Model

Use a hybrid model:

1. The main agent always owns premise checks, branch design, pruning, synthesis, and final judgment.
2. By default, explore branches in a single agent.
3. If the user explicitly asks for branch delegation or multiple researchers, and native delegation tools are available inside the current runtime, delegate selected branches through those native tools.
4. Do not launch separate CLI agents, separate CLI sessions, or separate CLI processes for the same research task.
5. If native agent tools are unavailable or not authorized by the user, continue as a single-agent branching workflow and state that limitation.

## Delegation Gate

Delegate only branches that are:

- independent enough to run without blocking the main path
- high-value enough to justify coordination cost
- clearly scoped by question, evidence target, and stopping condition
- unlikely to duplicate another active branch

Delegate the smallest set of branches that can produce independent value. Add another round only if synthesis exposes a material gap.

## Branch Assignment Contract

When delegating, give each agent:

- branch lens and research question
- scope boundaries
- preferred source type
- friction to watch for
- required return shape

Require compact returns:

- findings
- strongest evidence
- contradictions
- weak spots
- unexplored next branches
- confidence

## Evidence Ledger

Use a compact ledger when the task is large enough:

| Branch | Status | Strongest evidence | Friction | Next move | Confidence |
| --- | --- | --- | --- | --- | --- |

Keep the ledger short. It exists to prevent losing branches, not to create paperwork.

## Synthesis

Return the shape that best fits the user's request. Prefer:

- premise check
- bottom line
- branch findings
- recurring signals
- relationship structure
- contradiction zones
- unresolved uncertainty
- unexplored branches worth pursuing
- confidence estimate

Do not overproduce. The final answer should make the research state clearer than the raw search process.

## Stop Conditions

Converge when:

- the main answer is stable across independent evidence
- new searches mostly repeat known claims
- remaining unknowns cannot be resolved with available sources
- branch cost exceeds expected value
- the user's requested depth or time budget has been reached
