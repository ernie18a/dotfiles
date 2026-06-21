for user in e o n; do
      sudo mkdir -p /home/$user/.gemini
      sudo mkdir -p /home/$user/.claude
      sudo mkdir -p /home/$user/.hermes
      sudo mkdir -p /home/$user/.codex

      sudo rm -f /home/$user/.codex/AGENTS.md
      sudo rm -f /home/$user/.gemini/GEMINI.md
      sudo rm -f /home/$user/.hermes/SOUL.md
      sudo rm -f /home/$user/.claude/CLAUDE.md

      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.gemini/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.claude/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.hermes/skills
      sudo ln -snf /home/$user/.G/dotfiles/skills /home/$user/.codex/skills

      sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.codex/AGENTS.md
      sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.gemini/GEMINI.md
      sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.hermes/SOUL.md
      sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.claude/CLAUDE.md

      sudo chown -R $user:$user /home/$user
  done
