# Changelog

Tracks major changes pushed to `main`.

This project follows a rolling release model.

Changes are organized by date instead of version numbers.

---

## 2026-05-21

### Fixed

- Fixed startup layout bug when opening files directly from CLI

Previously:

```text
nvim file.py
→ opened in Zen layout incorrectly
```

Now:

```text
nvim file.py
→ opens directly in IDE layout
```

This keeps startup behavior consistent across:

- dashboard launches
- project picker launches
- new file workflows
- direct CLI file opens

---

## 2026-05-14

### Added

Initial public release.

### Core Features

- Modular Neovim architecture
- Dashboard workflow
- Project picker
- IDE / Zen layout system
- Pulse theme integration
- UpdateConfig command

### Language Workflows

Added complete workflow support for:

- Lua
- Python
- Shell

Each workflow includes:

- diagnostics
- format on save
- run support
- test support
- nearest test support
- debug support

### Debugging

Added:

- Python debugpy integration
- standalone Lua debugging
- Neovim Lua debugging (OSV)
- Shell trace debugging

### Installer System

Added:

- install.sh
- uninstall.sh
- dependency verification
- backup system
- repo clone / symlink install flow
- Python tools venv fallback
- LuaRocks workflow installs

### Documentation

Added:

- README
- INSTALLATION.md
- ARCHITECTURE.md
- KEYMAPS.md
- PLUGINS.md
- TROUBLESHOOTING.md
- language workflow docs