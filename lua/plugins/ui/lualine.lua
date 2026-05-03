-- ==========================================================
-- FILE: lua/plugins/ui/lualine.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Statusline styled with Pulse theme
-- ==========================================================

return {
	"nvim-lualine/lualine.nvim",

	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local theme = require("theme.dark").get()
		local python = require("adapters.python")

		local colors = {
			bg = theme.bg,
			bg_alt = theme.bg_alt,
			fg = theme.fg,
			fg_dim = theme.fg_dark,

			blue = theme.accent.blue,
			cyan = theme.accent.cyan,
			green = theme.accent.green,
			yellow = theme.accent.yellow,
			orange = theme.accent.orange,
			purple = theme.accent.purple,
			red = theme.diag.error,
		}

		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg_alt },
						c = { fg = colors.fg_dim, bg = colors.bg },
					},
					insert = {
						a = { fg = colors.bg, bg = colors.green, gui = "bold" },
					},
					visual = {
						a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
					},
					replace = {
						a = { fg = colors.bg, bg = colors.red, gui = "bold" },
					},
					command = {
						a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
					},
					inactive = {
						a = { fg = colors.fg_dim, bg = colors.bg },
						b = { fg = colors.fg_dim, bg = colors.bg },
						c = { fg = colors.fg_dim, bg = colors.bg },
					},
				},

				globalstatus = true,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename" },
				lualine_x = {
					python.lualine_venv,
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
