-- ==========================================================
-- FILE: lua/config/snacks/keymaps.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Register Snacks keymaps.
--
-- WHY IT EXISTS
-- -------------
-- Snacks keymaps should be separate from plugin loading and
-- dashboard layout.
--
-- HOW IT WORKS
-- ------------
-- The plugin spec passes the loaded Snacks module into setup().
-- This file then creates all Snacks-related keymaps.
--
-- FLOW
-- ----
-- 1. Snacks plugin loads.
-- 2. snacks.setup() runs.
-- 3. This file registers picker mappings.
--
-- BEGINNER NOTES
-- --------------
-- Terminal mappings are now handled by ToggleTerm.
-- ==========================================================

local M = {}

function M.setup(snacks)
	vim.keymap.set("n", "<leader>ff", function()
		snacks.picker.files()
	end, { desc = "Find Files" })

	vim.keymap.set("n", "<leader>fg", function()
		snacks.picker.grep()
	end, { desc = "Find Text" })

	vim.keymap.set("n", "<leader>fb", function()
		snacks.picker.buffers()
	end, { desc = "Find Buffers" })

	vim.keymap.set("n", "<leader>fh", function()
		snacks.picker.help()
	end, { desc = "Find Help" })
end

return M
