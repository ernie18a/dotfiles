---
name: subt2
description: Manual invocation only
---

# Subt2

Convert reduction and simplification goals into observable decisions and concrete code/prompt pruning.

# Rules

1. **Net Benefit**: Changes require a measurable benefit (e.g. reduced token count, fewer lines of code, simplified control path, lowered maintenance cost). If a proposed change does not produce such benefit, reject it.
2. **Redundant Pruning**: If a field, variable, or instruction is never read, computed, or passed to execution engines by downstream consumers, Then remove it immediately from schemas, validation, pipeline code, and prompts.
3. **Defensive Pruning**: If data or instructions exist solely for manual inspection, narrative derivation history, source citation, or hypothetical edge cases (e.g. `source_evidence`, `*_derivation`), Then eliminate them from data structures and prompts.
4. **Implicit State**: If a state or outcome can be directly inferred from primary data (e.g. non-empty string implies ready, empty implies skipped), Then do not declare redundant status enums or auxiliary origin flags (e.g. `exit_origin`).
5. **Actionable Instructions**: If prompt text does not directly map to the computation or format of a specific output field, Then delete it from the prompt.
6. **No Conservative Bias**: When pruning prompts, do not restrict changes to prompt text. If a schema or validation code enforces obsolete or defensive fields, update downstream validators and pipeline data structures simultaneously without preserving backward compatibility baggage.
