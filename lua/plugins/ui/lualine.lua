-- ==========================================================
-- FILE: lua/plugins/ui/lualine.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure the Neovim statusline using lualine.
--
-- WHY IT EXISTS
-- -------------
-- Provides persistent editor status information while matching
-- the Pulse theme system.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs lualine.
-- This file builds a custom theme using Pulse colors and
-- displays active editor information.
--
-- INSTALLATION
-- ------------
-- Installs:
-- - nvim-lualine/lualine.nvim
-- - nvim-web-devicons
--
-- CONFIGURATION
-- -------------
-- Configures:
-- - Pulse color integration
-- - editor mode display
-- - git branch info
-- - diff indicators
-- - filename display
-- - Python virtual environment indicator
-- - cursor progress/location
--
-- FLOW
-- ----
-- Neovim starts
-- → lualine loads
-- → Pulse theme colors are pulled
-- → statusline renders
--
-- BEGINNER NOTES
-- --------------
-- The Python virtual environment indicator comes from
-- adapters/python.lua.
--
-- Statusline styling should remain here.
-- Do not place workflow logic in this file.
-- ==========================================================

return {
	------------------------------------------
	-- INSTALLATION
	------------------------------------------
	"nvim-lualine/lualine.nvim",

	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	------------------------------------------
	-- CONFIGURATION
	------------------------------------------
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
