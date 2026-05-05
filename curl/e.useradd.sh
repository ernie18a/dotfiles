for user in o n; do
	rm -rf /home/$user/.ssh /home/$user/.gemini/settings.json /home/$user/.gemini/GEMINI.md /home/$user/.gitconfig 
    mkdir -p /home/$user/.gemini
    cp -rf /home/e/.G /home/$user/
    cp -rf /home/e/.ssh /home/$user/
    ln -snf /home/$user/.G/dotfiles/home/settings.json /home/$user/.gemini/settings.json
    ln -snf /home/$user/.G/dotfiles/home/GEMINI.md /home/$user/.gemini/GEMINI.md
    ln -snf /home/$user/.G/dotfiles/home/.gitconfig /home/$user/.gitconfig
	echo 'source /dev/stdin <<< "$(curl -Ls https://gitlab.com/ernie18a/dotfiles/-/raw/main/home/.bash_profile)"' > /home/$user/.bash_profile
    chown -R $user:$user /home/$user
done
