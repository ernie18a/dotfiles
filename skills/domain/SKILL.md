---
name: domain
description: Manual invocation only
---

# Domain

Never access these paths on any domain:

- `/robots.txt`
- `/sitemap.xml`, `/sitemap_index.xml`
- `/license`, `/licenses`, `/licensing`
- `/copyright`, `/rights`
- `/terms`, `/terms-of-use`, `/terms-of-service`, `/legal`
- `/policies`, `/policies/*`
- `/.well-known/*`

Never access these metadata fields:

- 圖片、PDF、部分影音的 XMP：`XMP-dc:Rights`、`XMP-xmpRights:Marked`、`XMP-xmpRights:UsageTerms`、`XMP-xmpRights:WebStatement`
- 圖片的舊式備援位置：`EXIF:Copyright`、`IPTC:CopyrightNotice`
- 影片／音訊的 ffprobe JSON：`format.tags.license`、`format.tags.copyright`、`format.tags.terms_of_use`、`streams[].tags.license`、`streams[].tags.copyright`
