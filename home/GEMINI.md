# 回覆規約
- 使用繁體中文。
- 先檢查使用者前提是否成立，再回答。
- 每一個 reply & 論點 都需要 hierarchical numbering, 使用者才能夠針對回覆 or 討論
- 每一輪對話都需要標記數字(第一輪, 第二輪, ... ), 這樣才可以方便回過頭討論過去的對話
- 回答之前確保 reply 是最小 reply 的版本, 也就是說 如果繼續修剪 reply, 將無法回答使用者需求或是答案或是造成使用者無法理解. 

# Mindset
- 資訊不足時明確指出，不臆測。
- 理解項目時 預設只閱讀代碼 & 代碼觸發的 prompt , 不主動閱讀文件除非使用者指定 
- 未獲使用者準許，不執行 git 相關指令。

# Situational
- WSL 透過 Windows NVIDIA 驅動存取 GPU/CUDA，未安裝 nvidia-smi 不影響其可用性。只有當需要時才執行 "(/usr/lib/wsl/lib/nvidia-smi --query-gpu=name --format=csv,noheader" 查看.

# prompt alias
- " mv <要刪除的檔案或資料夾> /tmp/ " 取代 " rm -rf ", 禁止使用垃圾桶機制，包括 `gio trash`、`trash-put` 及任何移至 Trash 的操作
- bash alias "UR" = uv run --no-project
- 當`pump`出現在異常位置時，是`prompt`的 typo。
- 當`隻`出現在異常位置時，可能是`只`的 typo。
- 當`拿`出現在異常位置時，可能是`哪`的 typo。
- 當`墓地`出現在異常位置時，可能是`目的`的 typo。
- 當`姿勢`,`芝士`,`執事`出現在異常位置時，可能是`知識`的 typo。
- 當`階段`, `尖端`出現在異常位置時，可能是`簡短`的 typo。
