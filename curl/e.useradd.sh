#!/bin/bash

# ── 1. 建群組 ──────────────────────────────────────────
sudo groupadd g

# ── 2. 建使用者 o, n ────────────────────────────────────
for user in o n; do
    sudo useradd "$user" -ms /bin/bash
    echo "$user:$user" | sudo chpasswd
done

# ── 3. 把 e, n, o 都加入群組 g ──────────────────────────
for u in e n o; do
    sudo usermod -aG g "$u"
done

# ── 4. 建立並設定 /g 目錄 ───────────────────────────────
sudo mkdir -p /g
sudo chown e:g /g
sudo chmod 2777 /g
sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g

# ── 5. 複製 dotfiles 並建立 symlinks ────────────────────
for user in e o n; do
    if [ "$user" != "e" ]; then
        # 清除並複製 dotfiles 實體內容（只有 o, n 需要）
        sudo rm -rf /home/$user/.*
        sudo cp -r /home/e/.G /home/$user/.G
    fi

    # 建立必要目錄
    sudo mkdir -p /home/$user/.gemini
    sudo mkdir -p /home/$user/.claude

    # 建立 symlinks
    sudo ln -snf /home/$user/.G/dotfiles/home/.bash_profile /home/$user/.bash_profile
    sudo ln -snf /home/$user/.G/dotfiles/home/.bash_profile /home/$user/.bashrc
    sudo ln -snf /home/$user/.G/dotfiles/home/.gitconfig    /home/$user/.gitconfig
    sudo ln -snf /home/$user/.G/dotfiles/home/.tmux.conf    /home/$user/.tmux.conf
    sudo ln -snf /home/$user/.G/dotfiles/home/.vimrc        /home/$user/.vimrc
    sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md     /home/$user/.gemini/GEMINI.md
    sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md     /home/$user/.claude/CLAUDE.md

    # 修正擁有者
    sudo chown -R $user:$user /home/$user/
done
