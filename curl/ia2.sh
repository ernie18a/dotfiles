install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://downloads.claude.ai/keys/claude-code.asc -o /etc/apt/keyrings/claude-code.asc
echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" | tee /etc/apt/sources.list.d/claude-code.list
curl -LsSf https://astral.sh/uv/install.sh | sh
install -m 0755 "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx" /usr/local/bin/
apt-get update ; apt-get install -yq claude-code
curl -fsSL https://antigravity.google/cli/install.sh | bash
mv /root/.local/bin/agy /bin/
chown -R e:e /home/e ; chown -R ubuntu:ubuntu /home/ubuntu
curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.useradd.sh | bash
curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash
