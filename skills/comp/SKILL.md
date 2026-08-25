---
name: comp
description: Manual invocation only
---

# comp

- Use only criteria that materially affect outcome quality; omit cosmetic or low-impact criteria.
- Derive criteria and justifications only from code, architecture, control flow, state transitions, interface contracts, integration paths, runtime behavior, tests, logs, and configuration.
- Exclude documentation, comments, READMEs, design docs, examples, and other explanatory text from comparison evidence unless the user explicitly includes them.
- For each criterion, let n be the number of compared items and split exactly ceil(n + n/2) whole-number points across all items.
- Rank by total score and briefly justify only the decisive differences.
