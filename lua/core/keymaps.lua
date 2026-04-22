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

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save / Quit
map("n", "<leader>w", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
