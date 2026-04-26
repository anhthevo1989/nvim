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
-- - Does NOT interfere with IDE layout
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
					position = "right",
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
		-- AUTO OPEN / CLOSE
		-- ======================================================

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
