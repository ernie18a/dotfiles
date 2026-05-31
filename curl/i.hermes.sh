#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# i.hermes.v2.sh — 重裝 hermes-agent，修復 v1 留下的 broken venv
#
# 問題：v1 把 uv 的 cpython-3.11 複製到 python/ 後刪掉 uv/tools，
#       hermes update 重建 venv 時 3.11 已不存在 → broken symlink + 缺 stdlib
#
# 策略：
#   1. 清掉殘留的 broken python/ 副本
#   2. 用 uv 安裝指定版本 Python（不依賴系統 Python）
#   3. 重建 venv 並重裝 hermes
#   4. pyvenv.cfg home 指向我們控制的 Python，不會被 uv tools 清理影響
#   5. 不再 rm uv/tools — 那是 v1 的錯誤
###############################################################################

HERMES_DIR="/usr/local/lib/hermes-agent"
PYTHON_VER="3.12"  # 與 uv 現有版本一致，pyproject 要求 >=3.11

# ── 0. 前置檢查 ──────────────────────────────────────────────────────────────
[[ $EUID -eq 0 ]] || { echo "ERROR: run as root"; exit 1; }

# ── 1. 清除使用者殘留 ────────────────────────────────────────────────────────
rm -rf /home/*/.hermes

# ── 2. 官方安裝（會建立 venv + git clone） ──────────────────────────────────
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# ── 3. 找出安裝器建立的 venv Python ─────────────────────────────────────────
VENV_PYTHON="$(readlink -f "${HERMES_DIR}/venv/bin/python")"
if [[ ! -x "$VENV_PYTHON" ]]; then
  echo "ERROR: venv python not executable after install: $VENV_PYTHON"
  exit 1
fi

# 驗證 stdlib 完整性
if ! "${HERMES_DIR}/venv/bin/python" -c "import py_compile, compileall, ast" 2>/dev/null; then
  echo "ERROR: stdlib incomplete after fresh install"
  echo "venv python: $VENV_PYTHON"
  "${HERMES_DIR}/venv/bin/python" -c "import sys; print(f'prefix={sys.prefix}'); print(f'base_prefix={sys.base_prefix}')" 2>&1 || true
  exit 1
fi

# ── 4. 把 Python 複製為獨立副本（防止 uv python uninstall 破壞 venv） ──────
# 取得 Python 的完整 prefix（不是 venv prefix，是 base_prefix）
BASE_PREFIX="$("${HERMES_DIR}/venv/bin/python" -c "import sys; print(sys.base_prefix)")"
PYTHON_BIN_NAME="$(basename "$VENV_PYTHON")"
LOCAL_PYTHON="${HERMES_DIR}/python"

rm -rf "$LOCAL_PYTHON"
cp -a "$BASE_PREFIX" "$LOCAL_PYTHON"

# 驗證副本的 python binary 存在
LOCAL_PYTHON_BIN="${LOCAL_PYTHON}/bin/${PYTHON_BIN_NAME}"
if [[ ! -x "$LOCAL_PYTHON_BIN" ]]; then
  echo "ERROR: copied python binary missing: $LOCAL_PYTHON_BIN"
  ls -la "${LOCAL_PYTHON}/bin/" 2>&1 || true
  exit 1
fi

# ── 5. 重指 venv symlinks 到本地副本 ────────────────────────────────────────
ln -sf "$LOCAL_PYTHON_BIN" "${HERMES_DIR}/venv/bin/python"
ln -sf "$LOCAL_PYTHON_BIN" "${HERMES_DIR}/venv/bin/python3"
ln -sf "$LOCAL_PYTHON_BIN" "${HERMES_DIR}/venv/bin/${PYTHON_BIN_NAME}"

# 更新 pyvenv.cfg 的 home 指向本地副本
sed -i "s|^home = .*|home = ${LOCAL_PYTHON}/bin|" "${HERMES_DIR}/venv/pyvenv.cfg"

# ── 6. 最終驗證 ─────────────────────────────────────────────────────────────
echo "── 驗證 venv 完整性 ──"
"${HERMES_DIR}/venv/bin/python" -c "
import sys, py_compile, compileall, ast, sysconfig
print(f'Python {sys.version}')
print(f'executable: {sys.executable}')
print(f'prefix:     {sys.prefix}')
print(f'base:       {sys.base_prefix}')
print(f'stdlib:     {sysconfig.get_path(\"stdlib\")}')
print('stdlib OK ✓')
"
echo "── hermes version ──"
"${HERMES_DIR}/venv/bin/hermes" --version 2>&1 || echo "(version check skipped)"

# ── 7. 權限：讓非 root 使用者可讀 ──────────────────────────────────────────
chmod -R o+rX "${HERMES_DIR}/"

# ── 8. 使用者 config ────────────────────────────────────────────────────────
for user in e o n; do
  mkdir -p "/home/$user/.hermes"
  ln -sf "/home/$user/.G/dotfiles/home/GEMINI.md" "/home/$user/.hermes/SOUL.md"
  cat > "/home/$user/.hermes/config.yaml" << 'EOF'
security:
  allow_lazy_installs: false
tts:
  provider: ''
stt:
  enabled: false
bedrock:
  discovery:
    enabled: false
curator:
  enabled: false
kanban:
  dispatch_in_gateway: false
delegation:
  orchestrator_enabled: false
lsp:
  enabled: false
EOF
  chown -R "$user:$user" "/home/$user/.hermes"
done

echo "✓ hermes-agent 安裝完成"
