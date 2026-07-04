#!/bin/bash

case "$1" in
  default)
    groupadd -f g
    for user in o n; do
      if ! id -u "$user" >/dev/null 2>&1; then
        useradd "$user" -ms /bin/bash
        echo "$user:$user" | chpasswd
      fi
    done
    for user in e o n; do
      if id -u "$user" >/dev/null 2>&1; then
        usermod -aG g "$user"
      fi
    done
    mkdir -p /g
    chown -R :g /g
    chmod -R 2777 /g
    setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g
    ;;
  reset)
    for user in o n; do
      if id -u "$user" >/dev/null 2>&1; then
        rm -rf /home/$user/.*
        cp -r /home/e/.G /home/$user/.G
        cp -r /home/e/.ssh /home/$user/.ssh
        cp -r /home/e/.55H /home/$user/
      fi
    done
    for user in e o n; do
      if id -u "$user" >/dev/null 2>&1; then
        rm -rf /home/$user/.gitconfig
        rm -rf /home/$user/.tmux.conf
        rm -rf /home/$user/.vimrc
        rm -rf /home/$user/.bash_profile
        rm -rf /home/$user/.bashrc
        rm -rf /home/$user/.codex
        rm -rf /home/$user/.gemini
        rm -rf /home/$user/.hermes
        rm -rf /home/$user/.claude
        mkdir -p /home/$user/.codex
        mkdir -p /home/$user/.gemini
        mkdir -p /home/$user/.hermes
        mkdir -p /home/$user/.claude
        echo 'source /dev/stdin <<< "$(curl -Ls "https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile?v=$(date +%s)")"' > /home/$user/.bash_profile
        ln -snf /home/$user/.G/dotfiles/home/.gitconfig /home/$user/.gitconfig
        ln -snf /home/$user/.G/dotfiles/home/.tmux.conf /home/$user/.tmux.conf
        ln -snf /home/$user/.G/dotfiles/home/.vimrc /home/$user/.vimrc
        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.codex/AGENTS.md
        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.codex/skills
        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.gemini/GEMINI.md
        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.gemini/skills
        ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.hermes/SOUL.md
        ln -snf /home/$user/.G/dotfiles/skills /home/$user/.hermes/skills
        chown -R $user:$user /home/$user/
      fi
    done
    if id -u e >/dev/null 2>&1; then
      ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
      ln -snf /home/e/.G/dotfiles/skills /home/e/.claude/skills
      chown -R e:e /home/e/.claude
    fi
    ;;
esac
