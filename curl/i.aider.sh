curl -LsSf https://aider.chat/install.sh | sh
AIDER_VENV=$(dirname $(dirname $(readlink -f /root/.local/bin/aider)))
mkdir -p /usr/local/lib/aider-chat
cp -r $AIDER_VENV/. /usr/local/lib/aider-chat/
AIDER_PYTHON=$(readlink -f /usr/local/lib/aider-chat/bin/python)
PYTHON_BIN_NAME=$(basename $AIDER_PYTHON)
mkdir -p /usr/local/lib/aider-chat/python/
cp -r $(dirname $(dirname $AIDER_PYTHON))/. /usr/local/lib/aider-chat/python/
NEW_PYTHON=/usr/local/lib/aider-chat/python/bin/${PYTHON_BIN_NAME}
ln -sf $NEW_PYTHON /usr/local/lib/aider-chat/bin/python
ln -sf $NEW_PYTHON /usr/local/lib/aider-chat/bin/python3
ln -sf $NEW_PYTHON /usr/local/lib/aider-chat/bin/${PYTHON_BIN_NAME}
ln -sf /usr/local/lib/aider-chat/bin/aider /usr/local/bin/aider
chmod -R o+rX /usr/local/lib/aider-chat/
rm -f /root/.local/bin/aider
rm -rf $AIDER_VENV
rm -rf /root/.local/share/uv/python/
rm -rf /root/.local/share/uv/tools/
