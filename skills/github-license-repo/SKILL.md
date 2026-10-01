---
name: github-license-repo
description: Manual invocation only
---

Check GitHub repositories in this order:

- `license.spdx_id`: record the GitHub API value. `null` or missing means undetected, not proven unlicensed; `NOASSERTION` needs manual review. Other IDs are automated matches, not complete permission checks.
- `commit_sha`: record the full SHA of the exact content checked or downloaded. Resolve branch or tag refs first. Missing SHA means the version cannot be verified.
- Check license statements at that same commit. Do not apply the current repository API license result to another commit or treat the two fields alone as proof of permission.

Report both values, the version-matched evidence, and any uncertainty briefly.
