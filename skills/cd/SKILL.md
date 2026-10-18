---
name: cd
description: Manual invocation only
---

- `/cd X` 指定要觀察的路徑，不是切換目錄。
- 路徑依 `~/.bash_profile` 的 `CD()` glob 規則，解析為 `ls -d /g/*/X/` 的結果。
