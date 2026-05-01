-- ==========================================================
-- FILE: lua/plugins/ui/dashboard.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure dashboard-nvim startup screen.
--
-- WHY IT EXISTS
-- -------------
-- Replaces Snacks dashboard while preserving existing workflow.
--
-- HOW IT WORKS
-- ------------
-- Uses adapter actions for all buttons.
--
-- FLOW
-- ----
-- Startup → dashboard loads → user selects action
--
-- BEGINNER NOTES
-- --------------
-- UI only. No workflow logic belongs here.
-- ==========================================================

local dashboard_actions = require("core.adapters.dashboard")

return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local dashboard = require("dashboard")
			local stats = require("lazy").stats()

			dashboard.setup({
				theme = "doom",

				config = {
					header = {
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"",
						"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
						"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
						"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
						"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
						"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
						"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
						"",
					},

					center = {
						{
							icon = " ",
							desc = "[ PROJECTS ]",
							key = "p",
							action = dashboard_actions.projects,
						},
						{
							icon = " ",
							desc = "[ NEW FILE ]",
							key = "n",
							action = dashboard_actions.new_file,
						},
						{
							icon = " ",
							desc = "[ RECENT FILES ]",
							key = "r",
							action = dashboard_actions.recent_files,
						},
						{
							icon = " ",
							desc = "[ CONFIG ]",
							key = "c",
							action = dashboard_actions.config,
						},
						{
							icon = " ",
							desc = "[ QUIT ]",
							key = "q",
							action = dashboard_actions.quit,
						},
					},

					footer = {
						"",
						string.format("󰒲 %d plugins loaded in %.2fms", stats.loaded, stats.startuptime),
					},
				},
			})

			-- Clean dashboard buffer UI
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dashboard",
				callback = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
					vim.opt_local.signcolumn = "no"
					vim.opt_local.foldcolumn = "0"
					vim.opt_local.statuscolumn = ""
					vim.opt_local.cursorline = false
					vim.opt_local.list = false
					vim.opt_local.fillchars = "eob: "
					vim.b.miniindentscope_disable = true
					vim.b.snacks_indent = false
					vim.b.snacks_scope = false
				end,
			})
		end,
	},
}
