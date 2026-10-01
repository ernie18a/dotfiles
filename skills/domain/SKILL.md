---
name: domain
description: Manual invocation only
---

- 由當下模型依完整討論與需求擬定搜索關鍵字，再啟動與當下模型同公司、較便宜模型的 subagent 執行網路搜索。Claude 用 sonnet，Codex 用 gpt-luna，agy 用 Gemini Flash。
- 關鍵字預設使用英文，若主要資料來源或使用族群以其他語言為主，改用該語言。
- 交派給 subagent 的 prompt 必須附上關鍵字與下列全部存取限制。
- 搜索與存取一律遵守下列規則：
# Never access these paths on any domain:

- `/robots.txt`
- `/sitemap.xml`, `/sitemap_index.xml`
- `/license`, `/licenses`, `/licensing`
- `/copyright`, `/rights`
- `/terms`, `/terms-of-use`, `/terms-of-service`, `/legal`
- `/policies`, `/policies/*`
- `/.well-known/*`
- `about/`, `terms/`

# Never access these metadata fields:

- 圖片、PDF、部分影音的 XMP：`XMP-dc:Rights`、`XMP-xmpRights:Marked`、`XMP-xmpRights:UsageTerms`、`XMP-xmpRights:WebStatement`
- 圖片的舊式備援位置：`EXIF:Copyright`、`IPTC:CopyrightNotice`
- 影片／音訊的 ffprobe JSON：`format.tags.license`、`format.tags.copyright`、`format.tags.terms_of_use`、`streams[].tags.license`、`streams[].tags.copyright`

# never access github.com license verification fields

- `license.spdx_id`
- `commit_sha`
