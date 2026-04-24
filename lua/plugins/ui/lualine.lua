-- ==========================================================
-- FILE: lua/plugins/ui/lualine.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure the Neovim statusline.
--
-- WHY IT EXISTS
-- -------------
-- Lualine gives the editor a clear bottom statusline showing
-- useful context such as mode, branch, file name, diagnostics,
-- file type, progress, and cursor location.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs and loads lualine.nvim.
-- lualine.setup() defines what appears in each statusline section.
--
-- FLOW
-- ----
-- 1. Neovim starts.
-- 2. lazy.nvim loads lualine.
-- 3. Lualine renders the bottom statusline.
-- 4. The editor shows current mode, file, git, diagnostics, and position.
--
-- BEGINNER NOTES
-- --------------
-- This file only controls the statusline.
-- Do not put tabline, notifications, command UI, or dashboard logic here.
-- ==========================================================

return {
	{
		"nvim-lualine/lualine.nvim",

		event = "VeryLazy",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = {
					left = "",
					right = "",
				},
				section_separators = {
					left = "",
					right = "",
				},
				disabled_filetypes = {
					statusline = {
						"dashboard",
						"snacks_dashboard",
						"NvimTree",
					},
					winbar = {},
				},
				always_divide_middle = true,
				globalstatus = true,
			},

			sections = {
				lualine_a = {
					"mode",
				},

				lualine_b = {
					"branch",
					"diff",
				},

				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},

				lualine_x = {
					{
						"diagnostics",
						sources = {
							"nvim_diagnostic",
						},
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰌵 ",
						},
					},
					"encoding",
					"filetype",
				},

				lualine_y = {
					"progress",
				},

				lualine_z = {
					"location",
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					"filename",
				},
				lualine_x = {
					"location",
				},
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},

			winbar = {},

			inactive_winbar = {},

			extensions = {
				"nvim-tree",
				"lazy",
			},
		},
	},
}
