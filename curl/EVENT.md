# uv install event

Date: 2026-06-04

## Background

The failed point is the version that installs uv directly into `/usr/local/bin` through `UV_INSTALL_DIR`:

```sh
curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
```

This appeared in `i.astral.uv.sh` at commit `d99fa3e` on 2026-05-23 09:47:10 +0800. Later `i.uv.sh` also used the same one-line setting.

## Version 1: current repo version

Current `i.apt.sh` no longer calls `curl/i.uv.sh`; it runs the Astral installer directly:

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Current `i.uv.sh` keeps the old system install command only as a comment and then runs the default installer:

```sh
# curl -LsSf https://astral.sh/uv/install.sh | UV_INSTALL_DIR=/usr/local/bin sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

If this script is executed as root, uv can land under root's private path, such as `/root/.local/bin/uv`, and may not be visible to normal users.

## Version 2: manual fixed version

The older working pattern before `UV_INSTALL_DIR=/usr/local/bin` was:

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
cp ~/.local/bin/* /usr/local/bin/
```

For the manual fix, moving the installed binaries into the system path is acceptable when the installer has already placed `uv` under the executing user's `~/.local/bin`:

```sh
sudo mv ~/.local/bin/* /usr/local/bin/
```

If the command is run from root, `~/.local/bin` means `/root/.local/bin`. If run from user `n`, it means `/home/n/.local/bin`.

To avoid deleting the global uv by mistake, only remove user `e`'s private uv when `which uv` resolves inside `/home/e/.local/bin`:

```sh
e_uv="$(sudo -u e bash -lc 'command -v uv || true')"
case "$e_uv" in
  /home/e/.local/bin/uv) sudo rm -f "$e_uv" ;;
  *) echo "skip delete: e resolves uv as ${e_uv:-not found}" ;;
esac
```

Then confirm executable permissions and user visibility:

```sh
sudo chmod 0755 /usr/local/bin/uv /usr/local/bin/uvx 2>/dev/null || true
ls -l /usr/local/bin/uv /usr/local/bin/uvx
sudo -u e bash -lc 'command -v uv && uv --version'
```

## Local execution note

In this session, `sudo` asked for a password, so the root-level `mv`, user `e` cleanup, and permission changes were not executed here.
