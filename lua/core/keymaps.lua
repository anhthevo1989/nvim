-- ==========================================================
-- PURPOSE
-- Define global keybindings
--
-- WHY IT EXISTS
-- Centralized interaction system
--
-- FLOW
-- Loads submodules for specific systems
-- ==========================================================

local map = vim.keymap.set

-- ----------------------------------------------------------
-- WINDOW NAVIGATION
-- ----------------------------------------------------------

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- ----------------------------------------------------------
-- SEARCH
-- ----------------------------------------------------------

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ----------------------------------------------------------
-- FILE CONTROL
-- ----------------------------------------------------------

map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")

-- ==========================================================
-- LOAD SYSTEM KEYMAPS
-- ==========================================================

require("core.keymaps.lsp")
require("core.keymaps.dap")
require("core.keymaps.run")
