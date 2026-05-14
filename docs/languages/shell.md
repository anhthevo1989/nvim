# SHELL LANGUAGE SUPPORT

## Purpose

This document explains how shell support works in this Neovim configuration.

The goal is to support shell scripting safely and clearly.

This guide only covers shell scripts.

---

## Target Result

Shell support is complete when the config can:

- highlight shell files
- attach a shell language server
- show diagnostics
- format shell scripts
- lint shell scripts
- run shell scripts
- validate the workflow before merging to `main`

---

## Shell Support Matrix

| Feature | Tool |
|---|---|
| Syntax / parsing | Treesitter `bash` |
| LSP | `bash-language-server` |
| Formatting | `shfmt` |
| Linting | `shellcheck` |
| Run | `sh` or `bash` |
| Test | `bats` |
| Debug | Bash trace debugging |

---

## Architecture Rules

Do not mix responsibilities.

### `plugins/`

Responsible for plugin setup, Treesitter setup, LSP setup, formatter setup, and linter setup.

### `adapters/`

Responsible for run logic and terminal routing.

### `core/keymaps/`

Responsible for keymaps only.

Do not put shell execution logic here.

### `validation/`

Responsible for proving shell support works before merging to `main`.

Validation files are internal testing files.

They are not installed for users.

---

## Step 1: Install System Requirements

Shell support expects:

```bash
bash
shfmt
shellcheck
```

Optional:

```bash
bash-language-server
shunit2
```

Validate:

```bash
bash --version
shfmt --version
shellcheck --version
```

---

## Step 2: Add Treesitter Support

Location:

```text
lua/plugins/treesitter/init.lua
```

Add:

```lua
"bash"
```

Validate:

- open a `.sh` file
- confirm highlighting works
- confirm indentation behaves correctly

---

## Step 3: Add Shell LSP Support

Location:

```text
lua/plugins/lsp/
```

Shell should use:

```text
bash-language-server
```

Validate:

- hover works where supported
- diagnostics appear
- shell syntax errors are detected

---

## Step 4: Add Formatting

Shell formatting should use:

```text
shfmt
```

Location:

```text
lua/plugins/formatting/
```

Validate:

- intentionally misformat a shell file
- save or run format command
- confirm formatting is corrected

---

## Step 5: Add Linting

Shell linting should use:

```text
shellcheck
```

Location:

```text
lua/plugins/linting/
```

Validate:

- create an intentional shell issue
- confirm diagnostics appear

Example:

```bash
unused_value="intentional shellcheck warning"
```

---

## Step 6: Add Run Support

Location:

```text
lua/adapters/run.lua
```

Recommended behavior:

```text
if filetype is sh:
  run the current file with its shebang when possible
  otherwise run with bash or sh
```

Common commands:

```bash
sh current_file.sh
bash current_file.sh
```

Validate:

```text
<leader>r
```

---

## Step 7: Optional Test Support

Shell testing is optional.

Possible tool:

```text
shunit2
```

Recommended command:

```bash
sh test_file.sh
```

Add test support only if shell tests become part of the workflow.

---

## Step 8: Debug Support

Shell debugging is not first-class in this config.

Start with:

- run support
- ShellCheck diagnostics
- clear terminal output

Only add shell debugging if there is a real need.

---

## Step 9: Create Shell Validation File

Location:

```text
validation/test.sh
```

Expected output:

```text
Hello, Neovim
Shell result: 42
```

---

## Shell Definition Of Done

Shell support is complete when:

- Treesitter highlights shell files
- bash-language-server attaches
- diagnostics appear
- shfmt formatting works
- ShellCheck linting works
- `<leader>r` runs shell scripts
- validation file passes
- docs are updated

---

## Final Rule

Shell support is complete when this loop works:

```text
open shell script
→ edit
→ LSP diagnostics
→ format
→ lint
→ run
→ commit
```


## Validation Commands

Run all shell tests:

```text
<leader>t
```

Run nearest shell test:

```text
<leader>tn
```

Debug shell scripts:

```bash
DEBUG=1 ./script.sh
```
