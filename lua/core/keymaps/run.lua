-- ==========================================================
-- FILE: lua/core/keymaps/run.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Defines keymaps for running code.
--
-- WHY IT EXISTS
-- -------------
-- Keymaps belong in core/keymaps while execution logic belongs in adapters.
--
-- HOW IT WORKS
-- ------------
-- This file connects user keymaps to the run adapter.
--
-- FLOW
-- ----
-- User presses <leader>r -> keymap calls adapter -> adapter runs file.
--
-- BEGINNER NOTES
-- --------------
-- This file should stay very small. It should never contain execution logic.
-- ==========================================================

local map = vim.keymap.set
local run = require("adapters.run")

------------------------------------------
-- RUN CURRENT FILE
------------------------------------------

map("n", "<leader>r", function()
	run.run_current_file()
end, {
	desc = "Run File",
})
