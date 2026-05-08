-- ==========================================================
-- FILE: lua/core/diagnostics.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Configure how LSP diagnostics (errors, warnings, hints)
-- are displayed in Neovim.
--
-- WHY IT EXISTS
-- -------------
-- Default diagnostic behavior should be explicitly defined
-- so UI behavior stays predictable across the config.
--
-- HOW IT WORKS
-- ------------
-- Uses vim.diagnostic.config() to control:
--
-- - virtual text
-- - signs
-- - underlines
-- - update timing
-- - floating windows
--
-- FLOW
-- ----
-- LSP publishes diagnostics
-- → Neovim receives diagnostics
-- → this config controls how they render
--
-- BEGINNER NOTES
-- --------------
-- Diagnostics = errors, warnings, and hints from LSP servers.
-- ==========================================================

------------------------------------------
-- DIAGNOSTIC DISPLAY CONFIG
------------------------------------------

vim.diagnostic.config({

	-- Show virtual text (inline errors)
	virtual_text = {
		prefix = "●", -- symbol before message
	},

	-- Show signs in gutter
	signs = true,

	-- Underline errors
	underline = true,

	-- Update while typing
	update_in_insert = true,

	-- Sort by severity
	severity_sort = true,

	-- Floating window config
	float = {
		border = "rounded",
		source = "always",
	},
})
