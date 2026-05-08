-- ==========================================================
-- FILE: lua/core/keymaps/search.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines keymaps for the internal Search / Replace workflow.
--
-- WHY IT EXISTS
-- -------------
-- Keymaps belong in core/keymaps so user interaction stays separate from
-- plugin setup and adapter logic.
--
-- HOW IT WORKS
-- ------------
-- Loads lua/adapters/search.lua and connects each public search function to
-- a leader key.
--
-- FLOW
-- ----
-- User presses a leader key -> keymap calls adapter function -> adapter runs
-- the search or replace workflow.
--
-- BEGINNER NOTES
-- --------------
-- This file does not perform search logic directly. It only connects keys to
-- functions.
-- ==========================================================

local search = require("adapters.search")

------------------------------------------
-- SEARCH
------------------------------------------

vim.keymap.set("n", "<leader>Sf", search.search_in_file, {
	desc = "Search in File",
})

vim.keymap.set("n", "<leader>Sp", search.search_in_project, {
	desc = "Search in Project",
})

------------------------------------------
-- REPLACE
------------------------------------------

vim.keymap.set("n", "<leader>Rf", search.replace_in_file, {
	desc = "Replace in File",
})

vim.keymap.set("n", "<leader>Rp", search.replace_in_project, {
	desc = "Replace in Project",
})
