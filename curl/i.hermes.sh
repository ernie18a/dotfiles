curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
VENV_PYTHON=$(readlink -f /usr/local/lib/hermes-agent/venv/bin/python)
PYTHON_VERSION_DIR=$(basename $(dirname $(dirname $VENV_PYTHON)))
PYTHON_BIN_NAME=$(basename $VENV_PYTHON)
mkdir -p /usr/local/lib/hermes-agent/python/
cp -r $(dirname $(dirname $VENV_PYTHON))/. /usr/local/lib/hermes-agent/python/
NEW_PYTHON=/usr/local/lib/hermes-agent/python/bin/${PYTHON_BIN_NAME}
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/python
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/python3
ln -sf $NEW_PYTHON /usr/local/lib/hermes-agent/venv/bin/${PYTHON_BIN_NAME}
chmod -R o+rX /usr/local/lib/hermes-agent/
rm -rf /root/.local/share/uv/python/
rm -rf /root/.local/share/uv/tools/
