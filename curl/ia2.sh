apt-get remove -y --allow-remove-essential needrestart ufw* apparmor* firewall* unattended-upgrades landscape-common ubuntu-advantage-tools cloud-init popularity-contest ubuntu-report apport whoopsie fwupd
apt-get update
apt-get install -yq apt-transport-https rsync software-properties-common sshpass tmux vim autossh bash-completion git jq file tree ffmpeg ripgrep cmake unzip acl rustfmt rustc cargo build-essential pkg-config rustc cargo build-essential pkg-config rustfmt 
curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
curl -LsSf https://astral.sh/uv/install.sh | sh
install -m 0755 "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx" /usr/local/bin/
apt-get update ; apt-get install -yq nodejs claude-code
curl -fsSL https://antigravity.google/cli/install.sh | bash
mv /root/.local/bin/agy /bin/
touch ~/.hushlogin /home/e/.hushlogin /home/ubuntu/.hushlogin
chown -R e:e /home/e ; chown -R ubuntu:ubuntu /home/ubuntu
if [ "$1" = "wsl" ]; then
	export WIN_USER=$(ls /mnt/c/Users | grep -iv "All\|Default\|desktop.ini\|Public\|USER\|Administrator\|super")
	export WIN_USER_DIR=/mnt/c/Users/$WIN_USER
	export WIN_USER_DL=/mnt/c/Users/$WIN_USER/Downloads
	unzip $WIN_USER_DL/ernie-master.zip
	mkdir ~/.ssh
	cat ernie-master/.ssh/id_ed25519 > ~/.ssh/id_ed25519
	cat ernie-master/.ssh/id_ed25519.pub > ~/.ssh/id_ed25519.pub
	chmod 0700 ~/.ssh
	chmod 0600 ~/.ssh/id_ed25519
	chmod 0644 ~/.ssh/id_ed25519.pub
	cp -rf ~/.ssh /home/e/.ssh
	chmod 0700 /home/e/.ssh
	chmod 0600 /home/e/.ssh/id_ed25519
	chmod 0644 /home/e/.ssh/id_ed25519.pub
	mkdir /home/e/.G/
	cd /home/e/.G/
	git clone git@github.com:ernie18a/dotfiles.git
	git clone git@github.com:ernie18a/misc.git
	git clone git@github.com:ernie18a/deprecated.git .deprecated
	git clone https://github.com/tmux-plugins/tpm /home/e/.G/.tmux_plugins_manager
	sed -i 's/https:\/\/github.com\/ernie18a\/dotfiles.git/git@github.com:ernie18a\/dotfiles.git/g' /home/e/.G/dotfiles/.git/config
	mkdir -p /home/e/.gemini
	mkdir -p /home/e/.claude
	mkdir -p /home/e/.hermes
	ln -snf /home/e/.G/dotfiles/home/.gitconfig /home/e/.gitconfig
	ln -snf /home/e/.G/dotfiles/home/.tmux.conf /home/e/.tmux.conf
	ln -snf /home/e/.G/dotfiles/home/.vimrc /home/e/.vimrc
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.gemini/GEMINI.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.claude/CLAUDE.md
	ln -snf /home/e/.G/dotfiles/home/GEMINI.md /home/e/.hermes/SOUL.md
	chown -R e:e /home/e
fi
curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/e.useradd.sh | bash
curl -fsSL https://raw.githubusercontent.com/ernie18a/dotfiles/refs/heads/main/curl/i.codex.sh | bash
