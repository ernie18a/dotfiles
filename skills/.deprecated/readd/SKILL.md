---
name: readd
description: Read specified large text files completely and extract only passages relevant to the user's prompt. Use for exhaustive, resumable reading that needs findings with source locations.
---

# Readd

Read every specified file completely using the largest practical reading units allowed by the model context and available tools. Do not use keyword search, sampling, or fixed-size chunking as a substitute for complete coverage.

Keep only the minimal progress state needed to preserve coverage across interruptions. Prefer file-level or section-level progress when sufficient; use line positions only when they are naturally available or needed to identify gaps.

Record only findings relevant to the prompt, with the file path and the most precise source location available at low cost.

Before reporting completion, verify that every specified file has been fully covered. If full coverage is uncertain, report the incomplete or uncertain files instead of claiming completion.
