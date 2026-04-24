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
-- 3. This file registers picker, terminal, and lazygit mappings.
--
-- BEGINNER NOTES
-- --------------
-- Add future Snacks keymaps here, not in the plugin spec.
-- ==========================================================

local M = {}

function M.setup(snacks)
	vim.keymap.set("n", "<leader>ff", function()
		snacks.picker.files()
	end, { desc = "Find Files" })

	vim.keymap.set("n", "<leader>fg", function()
		snacks.picker.grep()
	end, { desc = "Find Text" })

	vim.keymap.set("n", "<leader>tt", function()
		snacks.terminal.toggle()
	end, { desc = "Toggle Terminal" })

	vim.keymap.set("n", "<leader>gg", function()
		snacks.terminal.open("lazygit", {
			win = {
				position = "bottom",
				height = 0.3,
			},
		})
	end, { desc = "LazyGit (terminal split)" })
end

return M
