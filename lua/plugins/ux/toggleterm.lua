-- ==========================================================
-- FILE: lua/plugins/ux/toggleterm.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Provide persistent terminal management
-- ==========================================================

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",

		opts = {
			size = 15,
			open_mapping = nil, -- we handle mappings manually
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = false,
		},

		config = function(_, opts)
			require("toggleterm").setup(opts)

			local Terminal = require("toggleterm.terminal").Terminal

			local shell = Terminal:new({
				direction = "horizontal",
				size = 15,
			})

			local lazygit = Terminal:new({
				cmd = "lazygit",
				direction = "horizontal",
				size = 20,
			})

			vim.keymap.set("n", "<leader>tt", function()
				shell:toggle()
			end, { desc = "Terminal Shell" })

			vim.keymap.set("n", "<leader>tg", function()
				lazygit:toggle()
			end, { desc = "Terminal LazyGit" })
		end,
	},
}
