-- ==========================================================
-- FILE: lua/plugins/ui/which-key.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure which-key.nvim for keymap discovery
-- ==========================================================

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",

		opts = {
			preset = "modern",

			spec = {
				{ "<leader>s", group = "Select" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>e", group = "Explorer" },
				{ "<leader>r", group = "Run" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "Layout" },
			},
		},
	},
}
