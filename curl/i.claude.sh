curl -fsSL https://claude.ai/install.sh | bash
ln -snf "$HOME/.G/dotfiles/home/settings.json" "$HOME/.claude/settings.json"
"$HOME/.local/bin/claude" mcp add --transport http -s user op http://127.0.0.1:8766/op
"$HOME/.local/bin/claude" mcp add --transport http -s user sp http://127.0.0.1:8766/sp
