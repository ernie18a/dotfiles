---
name: rg2
description: Manual invocation only
disable-model-invocation: true
---

以使用者說明的方向，對指定範圍的文件窮舉分類，以整份檔案為比對單位。
未指定範圍時，只處理 `/g/data/tv26101718708/.read3/` 底下的檔案。

# 別名
- 別名一律英文，是同一概念在該領域實際通用的稱呼，包含同義詞、縮寫與詞形變化，不收會造成誤會的詞。
- 產生別名前不讀取搜索範圍內的檔案與檔名。
- 方向的別名寫入 `<D>/0.alias`；依方向列出類別，每類的別名寫入 `<D>/c/<類名>.alias`，類名用英文小寫與連字號，每行一詞。

# 搜索
- 開始時以 `mktemp -d /tmp/sift.XXXXXX` 建立工作目錄 `<D>`，後續沿用。
- 一律用 `rg`，固定字串、不分大小寫、只輸出檔名，不使用 `--hidden`。
- 方向：`rg -F -i -l -f <D>/0.alias <範圍> > <D>/0.files`；範圍是檔案清單時改用 `xargs -r -d '\n' rg -F -i -l -f <D>/0.alias < <清單> > <D>/0.files`
- 每類：`xargs -r -d '\n' rg -F -i -l -f <D>/c/<類名>.alias < <D>/0.files > <D>/c/<類名>.files`
- 剩餘：`cat <D>/c/*.files | sort -u | comm -23 <(sort <D>/0.files) - > <D>/rest.files`

# 回報
- 以 `wc -l` 計數：方向命中檔數、每類命中檔數與其 `.files` 路徑、剩餘檔數。

# 剩餘
- 剩餘檔數大於 0 時，讀剩餘檔中的方向命中行 `xargs -r -d '\n' rg -F -i -N --no-filename -f <D>/0.alias < <D>/rest.files`，補新類別與別名，重跑該類搜索與剩餘計算後重新回報。
