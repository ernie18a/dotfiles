curl -LsSf https://astral.sh/uv/install.sh | sh
if [ -x /root/.local/bin/uv ] && [ -x /root/.local/bin/uvx ]; then
  mv /root/.local/bin/uv /root/.local/bin/uvx /usr/local/bin/
  chmod 0755 /usr/local/bin/uv /usr/local/bin/uvx
fi
