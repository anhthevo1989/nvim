# Neovim Installer Bundle

Includes:

- `install.sh`
- `uninstall.sh`

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/anhthevo1989/nvim/main/install.sh | sh
```

## Uninstall

```sh
curl -fsSL https://raw.githubusercontent.com/anhthevo1989/nvim/main/uninstall.sh | sh
```

## Features

- POSIX shell
- no installer dependencies
- colored output
- step tracker
- multi-distro dependency maps
- minimal bootstrap dependency list
- standard or symlink install
- custom repo/config paths
- backups for config/data/cache/state
- repair mode
- dry-run mode
- skip-deps mode
- core tool verification

The installer handles:

- system dependencies
- Python workflow dependencies (debugpy + pytest)
- Lua workflow dependencies (busted)
- repo installation
- backups
- verification

Mason handles editor tooling after first launch:

- LSP servers
- formatters
- linters
