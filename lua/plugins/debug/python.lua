-- ==========================================================
-- FILE: lua/plugins/dap/python.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Python debugging using debugpy
-- ==========================================================

return {
	"mfussenegger/nvim-dap",

	config = function()
		local dap = require("dap")

		-- ------------------------------------------------------
		-- ADAPTER
		-- ------------------------------------------------------

		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}

		-- ------------------------------------------------------
		-- CONFIGURATION
		-- ------------------------------------------------------

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",

				program = "${file}",
				pythonPath = function()
					return "python"
				end,
			},
		}
	end,
}
