-- ==========================================================
-- PURPOSE
-- Configure editor behavior
--
-- WHY IT EXISTS
-- Centralized control of editor settings
--
-- HOW IT WORKS
-- Uses vim.opt to define options
--
-- FLOW
-- Applied globally after globals
--
-- BEGINNER NOTES
-- Controls how Neovim behaves
-- ==========================================================

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 8

opt.clipboard = "unnamedplus"

opt.updatetime = 250
opt.timeoutlen = 300
