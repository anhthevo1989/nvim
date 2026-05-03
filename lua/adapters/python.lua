-- ==========================================================
-- FILE: lua/adapters/python.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides Python project helpers for this Neovim config.
--
-- WHY IT EXISTS
-- -------------
-- Python workflow logic should stay separate from plugin setup, keymaps, and
-- editor defaults.
--
-- HOW IT WORKS
-- ------------
-- Checks common virtual environment signals and returns a short display name
-- that other UI components can use.
--
-- FLOW
-- ----
-- Lualine asks for Python venv text -> this adapter checks the environment ->
-- lualine displays the result.
--
-- BEGINNER NOTES
-- --------------
-- A virtual environment is a project-specific Python environment. It keeps
-- dependencies isolated from the system Python installation.
-- ==========================================================

local M = {}

local function path_exists(path)
	return vim.uv.fs_stat(path) ~= nil
end

local function basename(path)
	return vim.fn.fnamemodify(path, ":t")
end

local function find_project_venv()
	local root = vim.fn.getcwd()
	local candidates = {
		root .. "/.venv",
		root .. "/venv",
		root .. "/env",
	}

	for _, path in ipairs(candidates) do
		if path_exists(path) then
			return basename(path)
		end
	end

	return nil
end

function M.active_venv_name()
	local virtual_env = vim.env.VIRTUAL_ENV

	if virtual_env and virtual_env ~= "" then
		return basename(virtual_env)
	end

	return find_project_venv()
end

function M.lualine_venv()
	local venv_name = M.active_venv_name()

	if not venv_name then
		return "Python: no venv"
	end

	return "Python: " .. venv_name
end

return M
