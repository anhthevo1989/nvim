-- ==========================================================
-- FILE: lua/core/options.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Configure editor behavior.
--
-- WHY IT EXISTS
-- -------------
-- Keeps all global editor settings centralized so behavior
-- remains predictable and easy to modify.
--
-- HOW IT WORKS
-- ------------
-- Uses vim.opt to configure Neovim defaults.
--
-- FLOW
-- ----
-- init.lua loads core.options
-- → options are applied globally
-- → editor behavior updates
--
-- BEGINNER NOTES
-- --------------
-- These settings control how Neovim behaves globally.
-- ==========================================================

local opt = vim.opt

------------------------------------------
-- TABLINE
------------------------------------------

opt.showtabline = 2

------------------------------------------
-- LINE NUMBERS
------------------------------------------

opt.number = true
opt.relativenumber = true

------------------------------------------
-- INDENTATION
------------------------------------------

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

------------------------------------------
-- SEARCH
------------------------------------------

opt.ignorecase = true
opt.smartcase = true

------------------------------------------
-- UI
------------------------------------------

opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

------------------------------------------
-- SPLITS
------------------------------------------

opt.splitright = true
opt.splitbelow = true

------------------------------------------
-- SCROLL
------------------------------------------

opt.scrolloff = 8

------------------------------------------
-- CLIPBOARD
------------------------------------------

opt.clipboard = "unnamedplus"

------------------------------------------
-- RESPONSIVENESS
------------------------------------------

opt.updatetime = 250
opt.timeoutlen = 300
