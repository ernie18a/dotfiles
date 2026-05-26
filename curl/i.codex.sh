echo n | bash <(curl -fsSL https://chatgpt.com/codex/install.sh)

ln -sf /root/.codex/packages/standalone/current/bin/codex /bin/codex

for user in e o n; do
  mkdir -p /home/$user/.codex
  ln -sf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.codex/AGENTS.md
  chown -R $user:$user /home/$user
done
