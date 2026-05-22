sudo groupadd g
for user in o n; do
    sudo useradd "$user" -ms /bin/bash
    echo "$user:$user" | sudo chpasswd
done
for u in e n o; do
    sudo usermod -aG g "$u"
done
sudo mkdir -p /g
sudo chown e:g /g
sudo chmod 2777 /g
sudo setfacl -R -m u::rwx,g::rwx,o::rwx,m:rwx,d:u::rwx,d:g::rwx,d:o::rwx,d:m:rwx /g
for user in e o n; do
    if [ "$user" != "e" ]; then
        sudo rm -rf /home/$user/.*
        sudo cp -r /home/e/.G /home/$user/.G
        sudo cp -r /home/e/.ssh /home/$user/.ssh
        sudo cp -r /home/e/.55H /home/$user/
    fi
    sudo mkdir -p /home/$user/.gemini
    sudo mkdir -p /home/$user/.claude
    echo 'source /dev/stdin <<< "$(curl -Ls https://raw.githubusercontent.com/ernie18a/dotfiles/main/home/.bash_profile)"' | sudo tee /home/$user/.bash_profile > /dev/null
    sudo ln -snf /home/$user/.G/dotfiles/home/.gitconfig    /home/$user/.gitconfig
    sudo ln -snf /home/$user/.G/dotfiles/home/.tmux.conf    /home/$user/.tmux.conf
    sudo ln -snf /home/$user/.G/dotfiles/home/.vimrc        /home/$user/.vimrc
    sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md     /home/$user/.gemini/GEMINI.md
    sudo ln -snf /home/$user/.G/dotfiles/home/GEMINI.md     /home/$user/.claude/CLAUDE.md
    sudo chown -R $user:$user /home/$user/
done
