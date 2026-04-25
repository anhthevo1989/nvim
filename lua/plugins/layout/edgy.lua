-- ==========================================================
-- FILE: lua/plugins/layout/edgy.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Edgy.nvim as the IDE layout frame.
--
-- WHY IT EXISTS
-- -------------
-- Edgy owns the editor layout structure.
-- It keeps side and bottom panels predictable.
--
-- HOW IT WORKS
-- ------------
-- Edgy watches specific window types and places them at
-- predefined screen edges.
--
-- FLOW
-- ----
-- 1. Dashboard opens first.
-- 2. User opens a project or file.
-- 3. IDE layout opens automatically.
-- 4. nvim-tree stays left, terminal stays bottom.
--
-- BEGINNER NOTES
-- --------------
-- Edgy owns layout placement.
-- config.layout.ide owns automatic opening behavior.
-- ==========================================================

return {
	{
		"folke/edgy.nvim",

		event = "VeryLazy",

		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,

		opts = {
			animate = {
				enabled = false,
			},

			exit_when_last = false,

			left = {
				{
					title = "Files",
					ft = "NvimTree",
					size = { width = 32 },
					pinned = true,
					open = "NvimTreeOpen",
				},
			},

			bottom = {
				{
					title = "Terminal",
					ft = "toggleterm",
					size = { height = 0.3 },
					filter = function(_, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
			},
		},

		config = function(_, opts)
			require("edgy").setup(opts)
			require("config.layout.ide").setup()
		end,
	},
}
