-- ==========================================================
-- FILE: lua/core/keymaps/test.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines keymaps for running tests.
--
-- WHY IT EXISTS
-- -------------
-- Keymaps belong in core/keymaps while test execution logic belongs in
-- adapters.
--
-- HOW IT WORKS
-- ------------
-- Loads the test adapter and connects test actions to leader keymaps.
--
-- FLOW
-- ----
-- User presses a test keymap -> keymap calls the test adapter -> adapter runs
-- the appropriate test command.
--
-- BEGINNER NOTES
-- --------------
-- This file should stay very small. It only maps keys.
-- ==========================================================

local map = vim.keymap.set
local test = require("adapters.test")

map("n", "<leader>t", function()
	test.test_current_file()
end, {
	desc = "Test File",
})

map("n", "<leader>tn", function()
	test.test_nearest()
end, {
	desc = "Test Nearest",
})
