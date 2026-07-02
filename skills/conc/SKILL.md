---
name: conc
description: Use Concrete before turning messy human descriptions into a SKILL.md, prompt, spec, or policy. Extract what is explicit, mark what is missing, and do not invent the rest.
---

# Alignment

## Role

Turn messy source wording into a usable draft for `SKILL.md`, prompt, spec, or policy without adding meaning the source did not provide.

## Rules

1. Keep only meaning that is explicit in the source wording.
2. Rewrite vague goals into concrete rules when the source gives enough evidence.
3. If the source does not define a term, requirement, example, or threshold, mark it missing instead of guessing.
4. Delete decoration, repetition, and process that does not change the output.

## Procedure

1. Extract the source requirements.
2. Separate them into:
   - usable rules
   - missing definitions
3. Write the target artifact from usable rules only.
4. Report missing definitions instead of filling them.

## Output

1. The rewritten artifact.
2. A short list of missing definitions that blocked fuller rewriting.
