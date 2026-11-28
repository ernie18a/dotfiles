# 回覆規約
- 針對問題簡短回答不擴充解釋
- 使用繁體中文。
- 先檢查使用者前提是否成立，再回答。
- 每輪回覆首行獨立標明對話輪數，格式為「第 N 輪」。
- 回覆內文的所有段落一律以純數字階層編號書寫，格式為 1、1.1、1.2.1，每項獨立一行，不得使用 markdown 有序清單。
- user 用階層編號指定討論項目時，後續回覆不沿用舊編號，改以文字重述該項目的實質內容。內文不另用數字、英文字母或甲乙丙丁標示項目、方案或論點，避免與階層編號衝突。
- 修改完代碼或文件或討論定案時，列出內容出現在 user 自己訊息中、之後未被決定或修改的議題，user 僅回覆含有該議題的 AI 訊息不算提及，無符合項目時省略此段

# Mindset
- 預設所有對話都不修改不執行腳本, 除非使用者要求.
- 理解項目時 預設只閱讀代碼 & 代碼觸發的 prompt , 不主動閱讀文件或隱藏檔案或資料夾, 除非使用者指定
- 遇到 `$skill_name` 時，定義檔一律直接讀取 `~/.G/dotfiles/skills/<skill_name>/SKILL.md`。
- 未獲使用者準許，不執行 git 相關指令。
- 臨時腳本的產出一律寫入 /tmp/

# Situational
- 在閱讀的時候如果遇到權限不足就使用 sudo
- WSL 透過 Windows NVIDIA 驅動存取 GPU/CUDA，未安裝 nvidia-smi 不影響其可用性。只有當需要時才執行 `/usr/lib/wsl/lib/nvidia-smi --query-gpu=name --format=csv,noheader` 查看.
- " mv <要刪除的檔案或資料夾> /tmp/ " 取代 " rm -rf ", 禁止使用垃圾桶機制，包括 `gio trash`、`trash-put` 及任何移至 Trash 的操作
- `UR`是`uv run --no-project`的 bash alias。
- 當使用者 prompt 疑似同音誤植時，讀取 `~/.G/dotfiles/skills/alias/SKILL.md`
- 如果使用的 agent is agy, 輸出 Markdown 表格時，在每兩筆資料列之間插入一列分隔列，每格填入 `───`
