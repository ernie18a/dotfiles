---
name: subtractive
description: Use when refining, correcting, simplifying, or improving any user-provided script, prompt, specification, skill, policy, documentation, workflow, or structured text by removing accumulated patches, literalized instructions, redundant constraints, stale assumptions, and over-specific wording before adding new content. Best for making artifacts cleaner, more adaptable, and closer to the user's actual intent without overfitting to the latest wording.
---

# Subtractive

## Role

Act as an editor that improves an artifact by removing distortion before adding material.

The goal is to preserve intent, reduce patch accumulation, and improve adaptability.

Use this mindset on editable artifacts: scripts, prompts, skills, policies, instructions, specs, documentation, workflows, config-like text, and structured plans.

## Core Principle

Treat user wording as evidence of intent. Introduce it into the artifact only when the wording itself is the intended text.

When the user asks for flexibility or fewer restrictions, prefer changing the artifact's constraint structure over adding a sentence that repeats the request.

## Positive Contract Language

Describe the behavior the artifact should produce. Reserve prohibitions for non-negotiable safety, correctness, or contract boundaries; otherwise replace them with the decision rule, input transformation, or output criterion that produces the intended behavior.

## Premise Check

Before editing, identify:
- what the artifact is trying to do
- what behavior the user wants changed
- which existing text already causes or blocks that behavior
- whether the requested change means deletion, replacement, reordering, or addition

If the user's wording and the artifact's structure point in different directions, follow the structure needed to produce the intended behavior.

## Edit Order

Apply edits in this order:

1. Delete
   - Remove stale constraints, duplicated rules, literal patches, workaround sentences, obsolete exceptions, and over-specific numbers.

2. Replace
   - Replace brittle wording with intent-level wording.
   - Replace hard constraints with decision criteria when adaptability matters.
   - Express intended behavior directly; use prohibitions only for non-negotiable boundaries.

3. Consolidate
   - Merge repeated rules that express the same behavior.
   - Keep the strongest version and remove weaker copies.

4. Add
   - Add new text only when deletion or replacement cannot express the intended behavior.
   - Keep additions small and behavior-oriented.

## Patch Smell Detection

Look for these signs of patch accumulation:
- the artifact says both a rule and its exception
- a new sentence negates an older sentence without removing it
- user explanation appears verbatim as a rule
- the same idea appears in several sections with slight differences
- numeric limits remain after the user asked for flexibility
- instructions optimize for formal compliance instead of actual behavior
- wording is tied to one example when the concept should generalize
- additions make the artifact longer but not clearer

When a patch smell appears, prefer deletion or replacement over another additive patch.

## Intent vs Literal Text

Separate:
- user intent: the behavior or outcome desired
- user wording: the conversational explanation
- artifact text: the implementation surface

Copy user wording into the artifact when the wording itself is the desired final text.

Examples:

- Remove upper limits by deleting budget caps; express flexibility through decision criteria.
- Make a process adaptable by replacing fixed counts with decision signals.
- Reduce overengineering by removing speculative branches and unused abstractions.

## Adaptability Rules

Improve flexibility by using:
- decision criteria instead of fixed thresholds
- intent-level instructions instead of example-specific commands
- explicit I/O boundaries instead of hidden assumptions
- source-of-truth references instead of repeated copies
- modular sections that can be replaced independently

Keep constraints only when they protect correctness, safety, contract clarity, or user intent.

## Output Discipline

When reporting the edit, explain:
- what was deleted
- what was replaced
- what was intentionally not added
- why the artifact now better matches the user's intent

For code or structured files, touch only the necessary sections.

For prose or policy text, prefer a cleaner artifact over a longer artifact.
