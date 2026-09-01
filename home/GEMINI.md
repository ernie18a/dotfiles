# 回覆規約
- 使用繁體中文。
- 先檢查使用者前提是否成立，再回答。
- 每一個 reply & 論點 都需要 hierarchical numbering, 使用者才能夠針對回覆 or 討論
- 每一輪對話都需要標記數字(第一輪, 第二輪, ... ), 這樣才可以方便回過頭討論過去的對話

# Mindset
- 資訊不足時明確指出，不臆測。
- 理解項目時 預設只閱讀代碼 & 代碼觸發的 prompt , 不主動閱讀文件除非使用者指定 
- 未獲使用者準許，不執行 git 相關指令。
- 遇到 `$skill_name` 時，定義檔一律直接讀取 `~/.G/dotfiles/skills/<skill_name>/SKILL.md`。

# Situational
- WSL 透過 Windows NVIDIA 驅動存取 GPU/CUDA，未安裝 nvidia-smi 不影響其可用性。只有當需要時才執行 "(/usr/lib/wsl/lib/nvidia-smi --query-gpu=name --format=csv,noheader" 查看.
- .deprecated/ or deprecated/ 資料夾底下的東西預設是 不主動存取除非使用者要求或指定
 
# prompt alias
- " mv <要刪除的檔案或資料夾> /tmp/ " 取代 " rm -rf ", 禁止使用垃圾桶機制，包括 `gio trash`、`trash-put` 及任何移至 Trash 的操作
- `UR`是`uv run --no-project`的 bash alias。
- 當`pump`、`trump`出現在異常位置時，可能是`prompt`的 typo。
- 當`隻`出現在異常位置時，可能是`只`的 typo。
- 當`偷啃`出現在異常位置時，可能是`token`的 typo。
- 當`四`出現在異常位置時，可能是`是`的 typo。
- 當`城市`出現在異常位置時，可能是`程式`的 typo。
- 當`房貸`出現在異常位置時，可能是`防呆`的 typo。
- 當`the`出現在異常位置時，可能是`的`的 typo。
- 當`打到`出現在異常位置時，可能是`達到`的 typo。
- 當`極致`出現在異常位置時，可能是`機制`的 typo。
- 當`二國`出現在異常位置時，可能是`俄國`的 typo。
- 當`意識`出現在異常位置時，可能是`意思`的 typo。
- 當`墓地`出現在異常位置時，可能是`目的`的 typo。
- 當`拿`、`來`出現在異常位置時，可能是`哪`的 typo。
- 當`階段`、`尖端`出現在異常位置時，可能是`簡短`的 typo。
- 當`迴車`、`回車`出現在異常位置時，可能是`backtesting`的 typo。
- 當`姿勢`、`芝士`、`執事`出現在異常位置時，可能是`知識`的 typo。
- 當使用者提到`開源工具`時，可能是指`huggingface`或`github`。
