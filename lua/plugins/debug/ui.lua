-- ==========================================================
-- FILE: lua/plugins/debug/ui.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure dap-ui and integrate it with debug lifecycle.
--
-- FEATURES
-- --------
-- - Right-side debug panel
-- - Auto open on debug start
-- - Auto close on debug end
-- - Temporarily enters Zen layout while debugging
-- - Restores IDE layout when debugging ends
-- ==========================================================

return {
	"rcarriga/nvim-dap-ui",

	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.4 },
						{ id = "breakpoints", size = 0.2 },
						{ id = "stacks", size = 0.2 },
						{ id = "watches", size = 0.2 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 0.25,
					position = "bottom",
				},
			},
		})

		-- ======================================================
		-- DEBUG LAYOUT
		-- ======================================================

		local function enter_debug_layout()
			pcall(function()
				require("adapters.layout").zen_layout()
			end)

			vim.schedule(function()
				dapui.open()
			end)
		end

		local function exit_debug_layout()
			dapui.close()

			vim.schedule(function()
				pcall(function()
					require("adapters.layout").ide_layout()
				end)
			end)
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			enter_debug_layout()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			exit_debug_layout()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			exit_debug_layout()
		end
	end,
}
