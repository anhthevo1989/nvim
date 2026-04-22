-- ==========================================================
-- PURPOSE
-- Setup lazy.nvim plugin manager
--
-- WHY IT EXISTS
-- Provides structured plugin management system
--
-- HOW IT WORKS
-- Bootstraps lazy.nvim if missing, then initializes it
--
-- FLOW
-- bootstrap → runtimepath → setup
--
-- BEGINNER NOTES
-- This file controls all plugin loading
-- ==========================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {},
})
