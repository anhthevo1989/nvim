-- ==========================================================
-- FILE: lua/plugins/git/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Git integration using lazygit
-- ==========================================================

return {
	{
		"kdheepak/lazygit.nvim",

		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
		},

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		-- ======================================================
		-- KEYMAP (DEFINED AT PLUGIN LEVEL)
		-- ======================================================
		keys = {
			{
				"<leader>gg",
				"<cmd>LazyGit<CR>",
				desc = "Open LazyGit",
			},
		},
	},
}
