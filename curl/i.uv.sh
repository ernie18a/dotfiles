# 1. 安裝系統層級的 uv（不用 root 的 ~/.local）
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh

# 2. 安裝 hermes-agent
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# 3. 找出 venv 實際使用的 Python 路徑（不 hardcode 版本）
VENV_PYTHON=$(readlink -f /usr/local/lib/hermes-agent/venv/bin/python)
PYTHON_VERSION_DIR=$(basename $(dirname $(dirname $VENV_PYTHON)))
PYTHON_BIN_NAME=$(basename $VENV_PYTHON)

# 4. 複製 Python 到系統層級
mkdir -p /usr/local/share/uv/python/
cp -r $(dirname $(dirname $VENV_PYTHON)) /usr/local/share/uv/python/

# 5. 修正所有 symlink 指向系統層級
NEW_PYTHON=/usr/local/share/uv/python/${PYTHON_VERSION_DIR}/bin/${PYTHON_BIN_NAME}
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/python
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/python3
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/${PYTHON_BIN_NAME}

# 6. 開放所有用戶權限
chmod -R o+rX /usr/local/lib/hermes-agent/
chmod -R o+rX /usr/local/share/uv/

# 7. 清理 root 的私有 uv 避免混淆
rm -f /root/.local/bin/uv
rm -rf /root/.local/share/uv/

# 8. 驗證（把 e 換成你的實際用戶名）
echo "=== 驗證 symlink ==="
ls -la /usr/local/lib/hermes-agent/venv/bin/python
echo "=== 驗證普通用戶可用 ==="
su - e -c "hermes --version"
