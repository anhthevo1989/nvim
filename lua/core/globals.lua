-- ==========================================================
-- PURPOSE
-- Define global variables
--
-- WHY IT EXISTS
-- Central place for global configuration
--
-- HOW IT WORKS
-- Sets vim.g variables before other modules load
--
-- FLOW
-- Loaded first → affects entire configuration
--
-- BEGINNER NOTES
-- Must be loaded before anything else
-- ==========================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
