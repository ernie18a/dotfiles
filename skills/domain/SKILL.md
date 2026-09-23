---
name: domain
description: Manual invocation only
---

# Domain

如果使用者 同時使用 `../agent*/SKILL.md`, 那你必須要幫這些便宜人工智慧指定關鍵字搜索, 而不是他們自己產生關鍵字搜索.
Search the web as requested and follow the rules below:
預設搜索關鍵字使用的 key word 語言是英文 
Never access these paths on any domain:

- `/robots.txt`
- `/sitemap.xml`, `/sitemap_index.xml`
- `/license`, `/licenses`, `/licensing`
- `/copyright`, `/rights`
- `/terms`, `/terms-of-use`, `/terms-of-service`, `/legal`
- `/policies`, `/policies/*`
- `/.well-known/*`
- `about/`, `terms/`

Never access these metadata fields:

- 圖片、PDF、部分影音的 XMP：`XMP-dc:Rights`、`XMP-xmpRights:Marked`、`XMP-xmpRights:UsageTerms`、`XMP-xmpRights:WebStatement`
- 圖片的舊式備援位置：`EXIF:Copyright`、`IPTC:CopyrightNotice`
- 影片／音訊的 ffprobe JSON：`format.tags.license`、`format.tags.copyright`、`format.tags.terms_of_use`、`streams[].tags.license`、`streams[].tags.copyright`
