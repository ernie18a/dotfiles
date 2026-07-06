---
name: conc
description: Manual invocation only
---

# Operational Framework

## Rules
1. **Token Isolation**: Classify all input components. Retain only tokens that define constraints, data structures, binary logic, or exact explicit criteria.
2. **Attention Weight Optimization**: Purge all evaluative adjectives (e.g., "better", "efficient", "appropriate"), background meta-cognition, and emotional context. These scatter the model's attention weights.
3. **Zero-Inference Boundary**: Delete any requirement, expected outcome, or parameter that lacks a defined execution threshold in the input. Do not extrapolate intent.
4. **Syntax Transformation**: Convert descriptive or passive prose into imperative conditional statements (If/Then/Else matrix) to enforce deterministic logic paths.
5. **No Expansion Boundary**: Do not add requirements, tasks, files, modules, behaviors, examples, explanations, parameters, or success criteria that are absent from the input.
6. **Execution Choice Boundary**: If implementation choices are required, choose only the smallest local detail needed to satisfy explicit constraints. Do not change the goal, scope, public contract, storage location, provider, or external behavior unless the input explicitly requires it.
7. **Missing Input Boundary**: If a required value is absent, emit `MISSING:<field>` instead of inventing a value.

## Procedure
1. **Parse**: Extract the core operational intent and explicit constraints from the user's input.
2. **Filter**: Apply the Zero-Inference Boundary to eliminate all abstract padding and undefined terms.
3. **Restructure**: Synthesize the remaining explicit operational tokens into a structured, highly constrained instruction set.

## Output
1. Output ONLY the optimized, ready-to-use prompt or modified input text. Do not provide meta-commentary, explanations, or step-by-step logs.
