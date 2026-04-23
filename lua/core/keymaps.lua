-- ==========================================================
-- PURPOSE
-- Define keybindings
--
-- WHY IT EXISTS
-- Centralized interaction system
--
-- HOW IT WORKS
-- Uses vim.keymap.set
--
-- FLOW
-- Loaded after options
--
-- BEGINNER NOTES
-- Keymaps define how you control Neovim
-- ==========================================================

local map = vim.keymap.set

-- ==========================================================
-- WINDOW NAVIGATION
-- ==========================================================

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- ==========================================================
-- SEARCH
-- ==========================================================

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ==========================================================
-- FILE CONTROL
-- ==========================================================

map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

-- ==========================================================
-- LSP KEYMAPS (BUFFER-LOCAL)
-- ==========================================================
-- These only activate when an LSP attaches to a file

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- ------------------------------------------------------
    -- NAVIGATION
    -- ------------------------------------------------------

    -- Go to definition
    map("n", "gd", vim.lsp.buf.definition, opts)

    -- Go to references
    map("n", "gr", vim.lsp.buf.references, opts)

    -- Hover documentation
    map("n", "K", vim.lsp.buf.hover, opts)

    -- ------------------------------------------------------
    -- ACTIONS
    -- ------------------------------------------------------

    -- Rename symbol
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Code actions
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
