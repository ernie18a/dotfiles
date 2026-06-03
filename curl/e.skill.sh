for user in e o n; do
      sudo mkdir -p /home/$user/.gemini
      sudo mkdir -p /home/$user/.claude
      sudo mkdir -p /home/$user/.hermes
      sudo mkdir -p /home/$user/.codex

      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.gemini/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.claude/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.hermes/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.codex/skills

      sudo chown -h $user:$user /home/$user/.gemini/skills
      sudo chown -h $user:$user /home/$user/.claude/skills
      sudo chown -h $user:$user /home/$user/.hermes/skills
      sudo chown -h $user:$user /home/$user/.codex/skills
  done
