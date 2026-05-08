-- ==========================================================
-- FILE: lua/adapters/python.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Provide shared Python environment helpers.
--
-- WHY IT EXISTS
-- -------------
-- Python workflows need a consistent interpreter.
--
-- This adapter helps the run system, test system, debug system,
-- and statusline agree on which Python environment is active.
--
-- HOW IT WORKS
-- ------------
-- Checks for common virtual environment folders in the current
-- project root.
--
-- If a virtual environment is found, its Python interpreter is used.
-- If not, the system Python interpreter is used.
--
-- FLOW
-- ----
-- Python workflow asks for interpreter
-- → adapter checks project virtual environments
-- → matching interpreter is returned
-- → workflow uses that Python executable
--
-- BEGINNER NOTES
-- --------------
-- This file does not run Python code by itself.
--
-- It only tells other systems which Python executable to use.
-- ==========================================================

local M = {}

------------------------------------------
-- HELPERS
------------------------------------------

local function get_root()
	return vim.fn.getcwd()
end

local function get_candidates(root)
	return {
		root .. "/.venv/bin/python",
		root .. "/venv/bin/python",
		root .. "/env/bin/python",
	}
end

------------------------------------------
-- PYTHON DETECTION
------------------------------------------

function M.find_python()
	local root = get_root()
	local candidates = get_candidates(root)

	for _, python in ipairs(candidates) do
		if vim.fn.executable(python) == 1 then
			return python
		end
	end

	return "python"
end

function M.lualine_venv()
	local python = M.find_python()

	if python == "python" then
		return ""
	end

	local venv = python:match("([^/]+)/bin/python$")

	if not venv then
		return ""
	end

	return " " .. venv
end

return M
