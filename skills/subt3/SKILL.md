---
name: subt3
description: Manual invocation only
---

# Subt3

Simplify the specified target by removing unnecessary code or wording while preserving required behavior and serving the stated goal.

# Rules

1. **Net Benefit**: Make a change only when it provides a clear benefit to the stated goal, such as removing duplication, unnecessary complexity, or content that has no useful effect. If no clear benefit is established, leave it unchanged.

2. **Required Effect**: Remove an item only when it has no effect on the required behavior, decision, output, or format. Consider both direct and indirect effects before removing it.

3. **Non-functional Content**: Remove content that exists only to explain, record history, support inspection, or address possibilities not required by the stated goal. Retain it when it affects behavior, output, safety, or explicitly required compatibility.

4. **Duplicate State**: Do not add or retain separate state when the required result can be reliably determined from existing information. Preserve explicit state when the existing information is ambiguous or insufficient.

5. **Actionable Instructions**: Retain instructions that affect a required action, decision, output, or format. Remove instructions that affect none of these.

6. **Consistent Scope**: Apply necessary changes to every affected part of the target, including code, data definitions, validation, and prompts. Do not preserve obsolete structure solely for compatibility unless that compatibility is part of the stated goal.

7. **Context Independence**: Base decisions on the target's actual behavior and stated goal. Do not assume a particular schema, pipeline, field name, execution engine, data representation, or project structure unless the target explicitly requires it.
