-- ==========================================================
-- FILE: lua/core/globals.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Define global variables used across the entire config.
--
-- WHY IT EXISTS
-- -------------
-- Global settings must be initialized early before other
-- modules load and depend on them.
--
-- HOW IT WORKS
-- ------------
-- Sets vim.g variables that affect:
--
-- - leader keys
-- - provider loading
--
-- FLOW
-- ----
-- init.lua loads globals
-- → global variables are set
-- → remaining modules inherit these settings
--
-- BEGINNER NOTES
-- --------------
-- This file should load before plugins, keymaps, and
-- feature modules.
-- ==========================================================

------------------------------------------
-- LEADER KEYS
------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------------------------
-- DISABLE UNUSED PROVIDERS
------------------------------------------

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
