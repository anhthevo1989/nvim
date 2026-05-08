-- ==========================================================
-- FILE: lua/theme/state.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Persist Pulse theme state across sessions.
--
-- WHY IT EXISTS
-- -------------
-- Allows theme selection and transparency settings to survive
-- Neovim restarts.
--
-- HOW IT WORKS
-- ------------
-- - Stores state in a JSON file inside stdpath("state")
-- - Loads state on request
-- - Saves state after updates
--
-- FLOW
-- ----
-- 1. load() → read file → decode JSON → merge with defaults
-- 2. modify state in memory
-- 3. save() → encode JSON → write file
--
-- BEGINNER NOTES
-- --------------
-- If the file is missing or corrupted, defaults are used.
-- ==========================================================

local M = {}

local state_file = vim.fn.stdpath("state") .. "/pulse-theme.json"

local default = {
	theme = "dark",
	transparent = false,
}

------------------------------------------
-- LOAD STATE
------------------------------------------

function M.load()
	local ok, content = pcall(vim.fn.readfile, state_file)
	if not ok then
		return default
	end

	local ok_json, data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
	if not ok_json or type(data) ~= "table" then
		return default
	end

	return vim.tbl_deep_extend("force", default, data)
end

------------------------------------------
-- SAVE STATE
------------------------------------------

function M.save(state)
	local json = vim.fn.json_encode(state)
	vim.fn.writefile({ json }, state_file)
end

return M
