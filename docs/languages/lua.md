# LUA LANGUAGE SUPPORT

## Purpose

This document explains how Lua support works in this Neovim configuration.

The goal is to make Lua useful for both Neovim configuration development and standalone Lua scripting.

This guide only covers Lua.

---

## Target Result

Lua support is complete when the config can:

- highlight Lua files
- attach the Lua language server
- show diagnostics
- format Lua code
- run Lua files
- debug Lua inside Neovim
- debug standalone Lua scripts
- validate the workflow before merging to `main`

---

## Lua Support Matrix

| Feature | Tool |
|---|---|
| Syntax / parsing | Treesitter `lua` |
| LSP | `lua_ls` |
| Formatting | `stylua` |
| Linting | Optional `luacheck` |
| Run | `lua` |
| Test | `busted` |
| Neovim Lua Debug | `one-small-step-for-vimkind` |
| Standalone Lua Debug | `local-lua-debugger-vscode` |

---

## Architecture Rules

Do not mix responsibilities.

### `plugins/`

Responsible for plugin setup, Treesitter setup, LSP setup, formatter setup, and DAP adapter setup.

### `adapters/`

Responsible for run logic, debug workflow routing, and terminal routing.

### `core/keymaps/`

Responsible for keymaps only.

Do not put Lua execution logic here.

### `validation/`

Responsible for proving Lua support works before merging to `main`.

Validation files are internal testing files.

They are not installed for users.

---

## Step 1: Install System Requirements

Lua support expects:

```bash
lua
luarocks
```

Optional tools:

```bash
stylua
luacheck
```

Standalone Lua debugging should use:

```text
local-lua-debugger-vscode
```

OSV is for Lua running inside Neovim. `local-lua-debugger-vscode` is for normal Lua scripts.

Validate:

```bash
lua -v
luarocks --version
```

---

## Step 2: Add Treesitter Support

Location:

```text
lua/plugins/treesitter/init.lua
```

Add:

```lua
"lua"
```

Validate:

- open a `.lua` file
- confirm highlighting works
- confirm indentation behaves correctly

---

## Step 3: Add Lua LSP Support

Location:

```text
lua/plugins/lsp/
```

Lua should use:

```text
lua_ls
```

Validate:

- hover works
- rename works
- diagnostics appear
- code actions work

Important:

For Neovim config development, `lua_ls` should understand the `vim` global.

---

## Step 4: Add Formatting

Lua formatting should use:

```text
stylua
```

Location:

```text
lua/plugins/formatting/
```

Validate:

- intentionally misformat a Lua file
- save or run format command
- confirm formatting is corrected

---

## Step 5: Add Optional Linting

Lua linting can use:

```text
luacheck
```

This is optional.

Start with LSP diagnostics first.

Only add `luacheck` if it improves the workflow.

---

## Step 6: Add Run Support

Location:

```text
lua/adapters/run.lua
```

Recommended command:

```bash
lua current_file.lua
```

Validate:

```text
<leader>r
```

Expected:

- run terminal opens
- Lua file runs
- output appears in run terminal
- no duplicate terminal splits

---

## Step 7: Add Neovim Lua Debugging

Use this for debugging:

- Neovim config files
- plugin code
- keymaps
- autocommands
- startup behavior

Recommended tool:

```text
one-small-step-for-vimkind
```

This debugger attaches to Lua running inside Neovim.

---

## Step 8: Add Standalone Lua Debugging

Use this for debugging:

- normal Lua scripts
- external Lua tooling
- future standalone Lua projects
- possible window manager Lua experiments

Recommended tool:

```text
local-lua-debugger-vscode
```

DAP concept:

```lua
dap.adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = {
    "/path/to/local-lua-debugger-vscode/extension/debugAdapter.js",
  },
}

dap.configurations.lua = {
  {
    name = "Debug current Lua file",
    type = "local-lua",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = {
      lua = "lua",
      file = "${file}",
    },
    args = {},
  },
}
```

Validate:

- open standalone Lua file
- set breakpoint
- start debugger
- breakpoint is hit
- stepping works
- variables appear in dap-ui

---

## Step 9: Create Lua Validation File

Location:

```text
validation/test.lua
```

Expected output:

```text
Hello, Neovim
Lua result: 42
```

---

## Lua Definition Of Done

Lua support is complete when:

- Treesitter highlights Lua files
- `lua_ls` attaches
- diagnostics appear
- formatting works
- `<leader>r` runs Lua files
- OSV can debug Neovim Lua
- standalone Lua debugging works
- validation file passes
- docs are updated

---

## Final Rule

Lua support is complete when this loop works:

```text
open Lua file
→ edit
→ LSP diagnostics
→ format
→ run
→ debug
→ commit
```


## Test Validation

Run all Lua tests:

```text
<leader>t
```

Run nearest Lua test:

```text
<leader>tn
```
