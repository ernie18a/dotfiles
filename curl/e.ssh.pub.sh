KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJZmbeJC6+oRI/pOE9xJi0tYFLocBpo0+BgQ1WCSzb+w'
mkdir -p ~/.ssh
chmod 0700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
echo "$KEY" >> ~/.ssh/authorized_keys
