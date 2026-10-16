#!/usr/bin/env bash
for u in e o n; do
  sudo -u $u mkdir -p /home/$u/.codex /home/$u/.gemini/config
  sudo cp -f /home/e/.G/dotfiles/home/config.toml /home/$u/.codex/config.toml
  sudo cp -f /home/e/.G/dotfiles/home/mcp_config.json /home/$u/.gemini/config/mcp_config.json
  sudo chown $u:$u /home/$u/.codex/config.toml /home/$u/.gemini/config/mcp_config.json
  sudo chmod 600 /home/$u/.codex/config.toml
  out=$(sudo -u $u jq '.mcpServers.op={"type":"http","url":"http://127.0.0.1:8766/op"} | .mcpServers.debug={"type":"http","url":"http://127.0.0.1:8766/debug"}' /home/$u/.claude.json) \
    && printf '%s\n' "$out" | sudo -u $u tee /home/$u/.claude.json > /dev/null
done
