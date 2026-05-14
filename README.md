# Neovim

> A full-stack, beginner-friendly Neovim configuration built for clarity, consistency, and daily development.

This is a personal Neovim configuration shared as a complete development environment. It is designed to feel cohesive, readable, and practical without hiding how things work.

---

## Philosophy

This config is built around a few core principles:

- **Clarity over cleverness**  
  Files are organized by responsibility, not by shortcuts.

- **Consistency everywhere**  
  Keymaps, adapters, plugins, scripts, and docs follow the same structure.

- **Beginner-friendly by design**  
  Comments and documentation should explain why something exists, not just what it does.

- **Workflow-first development**  
  Languages are supported through complete workflows: edit, diagnose, format, run, test, debug.

- **Cohesive UI/UX**  
  The interface is designed to feel like one system instead of a pile of unrelated plugins.

---

## Features

- Lazy.nvim plugin management
- Treesitter syntax parsing
- LSP support
- Completion
- Diagnostics
- Formatting
- Linting
- Debugging with DAP
- Run/test adapters
- Dedicated terminal routing
- LazyGit integration
- Dashboard workflow
- Project picker
- Pulse theme system
- Beginner-friendly docs

---

## Language Workflows

The main supported languages are:

| Language | Run | Test | Nearest Test | Debug |
|---|---:|---:|---:|---:|
| Lua | Yes | Busted | Yes | OSV / local-lua-debugger-vscode |
| Python | Yes | Pytest | Yes | debugpy |
| Shell | Yes | Bats | Yes | DEBUG=1 trace mode |

---

## Installation

Install with:

```sh
curl -fsSL https://raw.githubusercontent.com/anhthevo1989/nvim/main/install.sh | sh
```

Then start Neovim:

```sh
nvim
```

The installer handles:

- system dependencies
- Python workflow tools
- Lua workflow tools
- repository setup
- backups
- verification

The default install mode clones the repo to:

```text
~/Projects/nvim
```

and links it to:

```text
~/.config/nvim
```

---

## Installer Options

Preview actions without changing anything:

```sh
sh install.sh --dry-run
```

Install using defaults:

```sh
sh install.sh --non-interactive
```

Skip dependency installation:

```sh
sh install.sh --skip-deps
```

Repair an existing install:

```sh
sh install.sh --repair
```

---

## Updating

From inside Neovim:

```vim
:UpdateConfig
```

This will:

```text
git fetch
→ git checkout main
→ git pull --ff-only
→ Lazy sync
→ restart prompt
```

---

## Uninstall

```sh
curl -fsSL https://raw.githubusercontent.com/anhthevo1989/nvim/main/uninstall.sh | sh
```

The uninstaller can remove:

- config path
- cloned repo
- Neovim data/cache/state
- Python workflow tools
- Lua workflow tools
- optional system dependencies

---

## Project Structure

```text
.
├── docs
├── init.lua
├── lua
│   ├── adapters
│   ├── core
│   ├── plugins
│   └── theme
├── install.sh
├── uninstall.sh
└── README.md
```

High-level responsibilities:

- `core/`  
  foundational Neovim behavior

- `plugins/`  
  plugin installation and configuration

- `adapters/`  
  workflow logic such as run, test, project opening, and layout routing

- `theme/`  
  Pulse theme system

- `docs/`  
  user-facing documentation

---

## Validation

Before merging major changes to `main`, validate:

```text
Lua
→ run
→ test
→ nearest test
→ debug

Python
→ run
→ test
→ nearest test
→ debug

Shell
→ run
→ test
→ nearest test
→ trace debug
```

Also check:

```vim
:checkhealth
:Lazy
:messages
```

Validation passes when:

- language workflows work
- formatting works
- diagnostics appear
- run/test/debug terminals behave correctly
- UI remains stable
- no unexpected runtime errors appear

---

## Release Model

This config uses a rolling release model.

Updates are pushed to `main` after they are built, tested, and validated. There are no version-numbered releases.

---

## Final Note

This is more than a config. It is a small development environment built around predictable workflows, readable files, and a cohesive user experience.

Welcome to Neovim.
