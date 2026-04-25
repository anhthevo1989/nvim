-- ==========================================================
-- FILE: lua/config/treesitter.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Treesitter-related behavior.
--
-- WHY IT EXISTS
-- -------------
-- Plugin declarations belong in lua/plugins/.
-- Runtime behavior belongs in lua/config/.
--
-- HOW IT WORKS
-- ------------
-- nvim-treesitter-textobjects is configured here.
-- Structural selections are enabled through textobjects.select.
--
-- FLOW
-- ----
-- 1. lazy.nvim loads Treesitter plugins.
-- 2. treesitter.lua calls this setup module.
-- 3. Textobjects become available for keymaps.
--
-- BEGINNER NOTES
-- --------------
-- Function and class selection depends on this file.
-- ==========================================================

local M = {}

function M.setup_textobjects()
	local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")

	if not ok then
		vim.notify("nvim-treesitter-textobjects not available", vim.log.levels.WARN)
		return
	end

	textobjects.setup({
		select = {
			lookahead = true,

			selection_modes = {
				["@function.outer"] = "V",
				["@class.outer"] = "V",
			},

			include_surrounding_whitespace = false,
		},
	})
end

return M
