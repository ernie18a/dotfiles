---
name: readd
description: Read specified large text files completely and extract only passages relevant to the user's prompt. Use for exhaustive, resumable reading that needs findings with file and line references.
---

# Readd

Read every specified file in contiguous line ranges. Keep each file's completed end line so interrupted work resumes at the next unread line.

For each range, record only findings relevant to the prompt, with the file path and start and end lines.

Before reporting completion, checkpoint that every specified file is read from its first line through its last line. Report incomplete files or ranges as incomplete.
