# PYTHON LANGUAGE SUPPORT

## Purpose

This document explains how Python support works in this Neovim configuration.

The goal is to provide a complete Python workflow without breaking the existing architecture.

This guide only covers Python.

---

## Target Result

Python support is complete when the config can:

- highlight Python files
- attach a Python language server
- show diagnostics
- format Python code
- lint Python code
- detect project virtual environments
- run Python files
- run Python tests
- debug Python applications
- validate the workflow before merging to `main`

---

## Python Support Matrix

| Feature | Tool |
|---|---|
| Syntax / parsing | Treesitter `python` |
| LSP | `pyright` |
| Formatting | `ruff format` |
| Linting | `ruff` |
| Run | `python` |
| Test | `pytest` |
| Debug | `debugpy` |
| Environments | `.venv` / virtualenv |

---

## Architecture Rules

Do not mix responsibilities.

### `plugins/`

Responsible for plugin setup, Treesitter setup, LSP setup, formatter setup, linter setup, and DAP adapter setup.

### `adapters/`

Responsible for run logic, test logic, debug workflow routing, terminal routing, and Python environment handling.

### `core/keymaps/`

Responsible for keymaps only.

Do not put Python execution logic here.

### `validation/`

Responsible for proving Python support works before merging to `main`.

Validation files are internal testing files.

They are not installed for users.

---

## Step 1: Install System Requirements

Python support expects:

```bash
python
python-pip
python-virtualenv
```

Recommended project tools:

```bash
Installer-managed Python tools:

- debugpy
- pytest

Mason-managed tooling:

- pyright
- ruff
```

Validate:

```bash
python --version
pip --version
```

---

## Step 2: Add Treesitter Support

Location:

```text
lua/plugins/treesitter/init.lua
```

Add:

```lua
"python"
```

Validate:

- open a `.py` file
- confirm highlighting works
- confirm indentation behaves correctly

---

## Step 3: Add Python LSP Support

Location:

```text
lua/plugins/lsp/
```

Python should use:

```text
pyright
```

Validate:

- hover works
- rename works
- diagnostics appear
- code actions work
- imports resolve correctly

---

## Step 4: Add Formatting

Python formatting should use one clear owner.

Recommended:

```text
ruff format
```

Location:

```text
lua/plugins/formatting/
```

Validate:

- intentionally misformat a Python file
- save or run format command
- confirm formatting is corrected

---

## Step 5: Add Linting

Python linting should use:

```text
ruff
```

Location:

```text
lua/plugins/linting/
```

Validate:

- create an unused variable
- confirm diagnostics appear

Example:

```python
unused_value = 42
```

---

## Step 6: Add Environment Handling

Python support should detect project environments.

Recommended priority:

```text
project .venv
→ project venv
→ project env
→ ~/.local/share/nvim-python-tools
→ system python
```

Validation:

- create `.venv`
- open Python project
- confirm LSP uses correct interpreter
- confirm run command uses correct interpreter

---

## Step 7: Add Run Support

Location:

```text
lua/adapters/run.lua
```

Recommended command:

```bash
python current_file.py
```

If a `.venv` exists, use the project interpreter.

Validate:

```text
<leader>r
```

---

## Step 8: Add Test Support

Location:

```text
lua/adapters/test.lua
```

Recommended command:

```bash
pytest
```

Expected behavior:

```text
<leader>t
```

Runs tests.

---

## Step 9: Add Debug Support

Location:

```text
lua/plugins/debug/
```

Python debugging should use:

```text
debugpy
```

Validate:

- set breakpoint
- start debugger
- breakpoint is hit
- stepping works
- variables show in dap-ui

---

## Step 10: Create Python Validation File

Location:

```text
validation/test.py
```

Expected output:

```text
Hello, Neovim
Python result: 42
```

---

## Python Definition Of Done

Python support is complete when:

- Treesitter highlights Python files
- Pyright attaches
- diagnostics appear
- formatting works
- Ruff linting works
- `.venv` detection works
- `<leader>r` runs Python files
- `<leader>t` runs Python tests
- debugpy launches
- breakpoints work
- dap-ui shows variables/scopes
- validation file passes
- docs are updated

---

## Final Rule

Python support is complete when this loop works:

```text
open Python project
→ edit
→ LSP diagnostics
→ format
→ lint
→ run
→ test
→ debug
→ commit
```
