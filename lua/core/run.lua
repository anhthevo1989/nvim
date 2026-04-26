-- ==========================================================
-- FILE: lua/core/run.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Run current file with smart language + environment detection.
--
-- FEATURES
-- --------
-- - Python venv detection (.venv / venv / env)
-- - Lua support
-- - Shell support
-- - Safe fallback to system executables
--
-- FLOW
-- ----
-- 1. Detect filetype
-- 2. Build run command
-- 3. Execute in betterTerm run terminal
-- ==========================================================

local M = {}

-- ==========================================================
-- VENV DETECTION
-- ==========================================================

local function find_venv_python()
	local root = vim.fn.getcwd()

	local candidates = {
		root .. "/.venv/bin/python",
		root .. "/venv/bin/python",
		root .. "/env/bin/python",
	}

	for _, path in ipairs(candidates) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end

	return "python"
end

-- ==========================================================
-- COMMAND BUILDERS
-- ==========================================================

local function build_python_cmd(file)
	local python = find_venv_python()
	return string.format("%s %s", python, file)
end

local function build_lua_cmd(file)
	return string.format("lua %s", file)
end

local function build_shell_cmd(file)
	return string.format("bash %s", file)
end

-- ==========================================================
-- RUN
-- ==========================================================

function M.run()
	local file = vim.fn.expand("%:p")
	local ft = vim.bo.filetype

	local cmd

	if ft == "python" then
		cmd = build_python_cmd(file)
	elseif ft == "lua" then
		cmd = build_lua_cmd(file)
	elseif ft == "sh" then
		cmd = build_shell_cmd(file)
	else
		vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
		return
	end

	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		vim.notify("betterTerm not available", vim.log.levels.ERROR)
		return
	end

	-- reuse run terminal (id = 2)
	better_term.open(2, cmd)
end

-- ==========================================================
-- KEYMAP
-- ==========================================================

vim.keymap.set("n", "<leader>r", function()
	M.run()
end, { desc = "Run current file" })

return M
