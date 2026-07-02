---
name: lazy
description: Convert a request into the smallest verifiable completion contract. Use when working with low-cost or unreliable agents, or when a task risks being declared complete without sufficient evidence, across coding, search, reading, document, data, and operational work.
---

# Lazy

Make completion cheap to verify, not verbose to describe.

1. Infer the task structure: modify, find, understand, transform, or operate. Combine structures when needed; do not route by keywords or domain labels.
2. Keep only facts that decide completion: intended deliverable, material constraints, and observable result.
3. Choose the cheapest available evidence. Prefer existing command output, file state, source link, count, diff, or direct inspection over a new checklist or explanation.
4. Check evidence as part of execution. Do not create a separate validation phase when the check costs more than the likely rework or failure.
5. Separate facts supported by evidence from requests that cannot be verified. State the latter as unresolved; never replace evidence with self-attestation.

Do not add domain playbooks, keyword triggers, narrated reasoning, or generic checklists. Do not claim completion when a material condition has no evidence.
