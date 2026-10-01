---
name: domain
description: Manual invocation only
---

- 把理解過後 的關鍵字交給 相對便宜的人工智慧像是 sonnet or gpt-luna 執行網路搜索 
- Search the web as requested and follow the rules below:
- 預設搜索關鍵字使用的 key word 語言是英文,  但會根據最大資料來源 or 使用群眾來選擇語言
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

# never access github.con license verification fields

- `license.spdx_id`
- `commit_sha`
