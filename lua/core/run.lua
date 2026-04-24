-- ==========================================================
-- FILE: lua/core/run.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Run current file based on filetype
--
-- SUPPORTED
-- ---------
-- - lua
-- - python
-- - sh / bash
--
-- NOTES
-- -----
-- Keeps terminal open after execution so output is visible
-- ==========================================================

local M = {}

function M.run()
	local ft = vim.bo.filetype
	local file = vim.fn.expand("%")

	if file == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return
	end

	local shell_cmd = nil

	if ft == "lua" then
		shell_cmd = "lua " .. file
	elseif ft == "python" then
		shell_cmd = "python " .. file
	elseif ft == "sh" or ft == "bash" then
		shell_cmd = "bash " .. file
	else
		vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
		return
	end

	-- Wrap command so terminal stays open
	local cmd = "bash -c '" .. shell_cmd .. '; echo; read -n 1 -s -r -p "Press any key to continue..."\''

	require("snacks.terminal").open(cmd, {
		win = {
			position = "bottom",
			height = 0.3,
		},
	})
end

return M
