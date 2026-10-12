# Handy Linux 錄音與輸出核心修復紀錄

## 1. 錄音問題：硬體格式不相容 (sample count: 0)
*   **修復關鍵**：加入環境變數強制使用 PulseAudio 相容層。
*   **修改檔案**：`/etc/environment`
*   **加入內容**：
    ```bash
    CPAL_ASHA_HOST=pulseaudio
    ```
*   **生效方式**：修改後需「登出並重新登入」。

## 2. 輸出問題：與 fcitx 中文輸入法衝突 (文字只出一個字)
*   **修復關鍵**：將貼上模式從模擬按鍵改為剪貼簿。
*   **修改檔案**：`/home/e/.local/share/com.pais.handy/settings_store.json`
*   **修改內容**：
    ```json
    "paste_method": "ctrl_v"
    ```
*   **生效方式**：修改後「重啟 Handy」程式。
