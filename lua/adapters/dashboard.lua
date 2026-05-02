-- ==========================================================
-- FILE: lua/core/adapters/dashboard.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Centralized dashboard actions.
--
-- WHY IT EXISTS
-- -------------
-- Prevents dashboard plugins from owning workflow logic.
--
-- HOW IT WORKS
-- ------------
-- Any dashboard UI calls these functions.
--
-- FLOW
-- ----
-- Dashboard button → adapter → underlying system
--
-- BEGINNER NOTES
-- --------------
-- This allows easy dashboard swapping later.
-- ==========================================================

local M = {}

-- ==========================================================
-- PROJECTS
-- ==========================================================

function M.projects()
	require("adapters.projects").open_project_picker()
end

-- ==========================================================
-- NEW FILE
-- ==========================================================

function M.new_file()
	vim.cmd("ene")

	vim.schedule(function()
		require("config.layout.ide").ide_layout()
		vim.cmd("startinsert")
	end)
end

-- ==========================================================
-- RECENT FILES
-- ==========================================================

function M.recent_files()
	Snacks.picker.recent()
end

-- ==========================================================
-- CONFIG
-- ==========================================================

function M.config()
	Snacks.picker.files({
		cwd = vim.fn.stdpath("config"),
	})
end

-- ==========================================================
-- QUIT
-- ==========================================================

function M.quit()
	vim.cmd("qa")
end

return M
