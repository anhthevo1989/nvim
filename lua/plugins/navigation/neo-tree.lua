-- ==========================================================
-- FILE: lua/plugins/navigation/neo-tree.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Provide file explorer via Neo-tree.
--
-- WHY IT EXISTS
-- -------------
-- Neo-tree replaces nvim-tree and provides a stable sidebar.
--
-- HOW IT WORKS
-- ------------
-- <leader>ex opens or focuses the explorer.
-- It does not toggle closed.
-- Zen layout is responsible for closing the explorer.
--
-- BEGINNER NOTES
-- --------------
-- Use the :Neotree command for reliable lazy-loading.
-- ==========================================================

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},

		cmd = "Neotree",

		keys = {
			{
				"<leader>ex",
				"<cmd>Neotree reveal left filesystem<CR>",
				desc = "Explorer Focus",
			},
		},

		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",

			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
			},

			window = {
				position = "left",
				width = 30,
			},
		},
	},
}
