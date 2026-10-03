cd /tmp

curl -fL -O \
  https://github.com/astral-sh/ruff/releases/latest/download/ruff-x86_64-unknown-linux-gnu.tar.gz

tar -xzf ruff-x86_64-unknown-linux-gnu.tar.gz

sudo install -m 0755 \
  ruff-x86_64-unknown-linux-gnu/ruff \
  /usr/local/bin/ruff

ruff --version
