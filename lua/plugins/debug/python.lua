-- ==========================================================
-- FILE: lua/plugins/dap/python.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Python debugging using debugpy.
--
-- WHY IT EXISTS
-- -------------
-- Python debugging should use the same project environment as
-- the run system and Pyright.
--
-- HOW IT WORKS
-- ------------
-- - Detects .venv / venv / env in the project root
-- - Uses that Python interpreter when available
-- - Falls back to system python
-- - Launches debugpy through python -m debugpy.adapter
--
-- FLOW
-- ----
-- 1. User starts debugging
-- 2. DAP starts debugpy adapter
-- 3. Current Python file launches
-- 4. Breakpoints can be hit
-- ==========================================================

return {
	"mfussenegger/nvim-dap",

	config = function()
		local dap = require("dap")

		local function find_python()
			local root = vim.fn.getcwd()

			local candidates = {
				root .. "/.venv/bin/python",
				root .. "/venv/bin/python",
				root .. "/env/bin/python",
			}

			for _, python in ipairs(candidates) do
				if vim.fn.executable(python) == 1 then
					return python
				end
			end

			return "python"
		end

		dap.adapters.python = {
			type = "executable",
			command = find_python(),
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = find_python,
			},
		}
	end,
}
