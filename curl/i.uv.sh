# curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
curl -LsSf https://astral.sh/uv/install.sh | sh
install -m 0755 "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx" /usr/local/bin/
