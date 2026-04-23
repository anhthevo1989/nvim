-- ==========================================================
-- FILE: lua/plugins/debug/ui.lua
-- ==========================================================
-- PURPOSE
-- -------
-- UI for debugging using nvim-dap-ui
--
-- WHAT THIS DOES
-- --------------
-- - Adds panels for variables, stack, breakpoints
-- - Auto-opens UI on debug start
-- - Auto-closes on debug end
-- ==========================================================

return {
	{
		"rcarriga/nvim-dap-ui",

		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

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
	},
}
