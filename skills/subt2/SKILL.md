---
name: subt2
description: Manual invocation only
---

# Subt2

- Changes require a measurable net benefit toward the stated goal, such as less code, fewer tokens, or a simpler control path. If no such benefit is produced, leave the target unchanged.
- 移除 redundant coding and wording. 若某個狀態可以由既有資訊直接推導出來, 就不要另外宣告重複的狀態或旗標.
- 移除 defensive coding and wording. 但是會影響行為, 輸出, 安全性, 或者屬於明確要求之相容性的內容, 必須保留.
- 移除 non-actionable instruction writing and wording. 也就是移除沒有對應到任何必要決策, 行為, 或輸出格式的敘述.
- 移除 conservative bias. 異動必須一致套用到 code, schema, validation, 和 prompt 等所有受影響的部分, 不能因為相容性考量而保留冗餘結構.
- 不要預設特定的 schema, pipeline, 欄位名稱, 或執行引擎, 除非目標本身明確要求. 判斷依據應該是目標對象實際的行為, 以及陳述的目標.
