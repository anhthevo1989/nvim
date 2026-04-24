-- ==========================================================
-- FILE: lua/plugins/ui/noice.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Noice.nvim as the UI message and command-line layer.
--
-- WHY IT EXISTS
-- -------------
-- Noice improves Neovim's command line, messages, and popup menu.
-- It gives the UI a cleaner, more intentional feel.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs and loads Noice.
-- Noice takes over selected UI surfaces:
-- - command line
-- - messages
-- - popup menu
--
-- FLOW
-- ----
-- 1. Neovim starts.
-- 2. Noice loads after startup.
-- 3. Command-line and messages use Noice views.
--
-- BEGINNER NOTES
-- --------------
-- Snacks still owns picker, input, terminal, and dashboard.
-- Noice owns command-line and message display only.
-- LSP hover and signature are disabled here to avoid UI conflicts.
-- ==========================================================

return {
	{
		"folke/noice.nvim",

		event = "VeryLazy",

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},

		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",

				format = {
					cmdline = {
						pattern = "^:",
						icon = "",
						lang = "vim",
					},
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = " ",
						lang = "regex",
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = " ",
						lang = "regex",
					},
					filter = {
						pattern = "^:%s*!",
						icon = "$",
						lang = "bash",
					},
					lua = {
						pattern = {
							"^:%s*lua%s+",
							"^:%s*lua%s*=",
							"^:%s*=%s*",
						},
						icon = "",
						lang = "lua",
					},
					help = {
						pattern = "^:%s*he?l?p?%s+",
						icon = "󰋖",
					},
				},
			},

			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = false,
			},

			popupmenu = {
				enabled = true,
				backend = "nui",
			},

			notify = {
				enabled = true,
				view = "notify",
			},

			lsp = {
				progress = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
				message = {
					enabled = true,
					view = "notify",
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
			},

			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},

			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = {
						skip = true,
					},
				},
			},
		},
	},
}
