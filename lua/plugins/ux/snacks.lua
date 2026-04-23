-- ==========================================================
-- FILE: lua/plugins/ux/snacks.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Snacks UX layer with unified terminal system
-- ==========================================================

return {
	{
		"folke/snacks.nvim",

		opts = {
			picker = { enabled = true },

			terminal = {
				enabled = true,
				win = {
					position = "bottom",
					height = 0.3,
				},
			},

			notifier = { enabled = true },
			input = { enabled = true },
			scope = { enabled = true },
		},

		config = function(_, opts)
			local snacks = require("snacks")
			snacks.setup(opts)

			-- ======================================================
			-- TERMINAL TOGGLE (BOTTOM SPLIT)
			-- ======================================================
			vim.keymap.set("n", "<leader>tt", function()
				snacks.terminal.toggle()
			end, { desc = "Toggle Terminal" })

			-- ======================================================
			-- LAZYGIT IN TERMINAL (FORCED SPLIT)
			-- ======================================================
			vim.keymap.set("n", "<leader>gg", function()
				snacks.terminal.open("lazygit", {
					win = {
						position = "bottom",
						height = 0.3,
					},
				})
			end, { desc = "LazyGit (terminal split)" })
		end,
	},
}
