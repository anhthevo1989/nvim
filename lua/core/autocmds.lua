-- ==========================================================
-- FILE: lua/core/autocmds.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Define automatic commands.
--
-- WHY IT EXISTS
-- -------------
-- Automates repetitive editor behaviors.
--
-- HOW IT WORKS
-- ------------
-- Uses Neovim API to attach callbacks to editor events.
--
-- FLOW
-- ----
-- Event occurs
-- → autocmd triggers
-- → callback runs
--
-- BEGINNER NOTES
-- --------------
-- Autocommands react to editor actions automatically.
-- ==========================================================

local autocmd = vim.api.nvim_create_autocmd

------------------------------------------
-- HIGHLIGHT ON YANK
------------------------------------------

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

------------------------------------------
-- REMOVE TRAILING WHITESPACE ON SAVE
------------------------------------------

autocmd("BufWritePre", {
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

------------------------------------------
-- DIAGNOSTICS CONFIG
------------------------------------------
-- PURPOSE
-- -------
-- Configure how diagnostics (errors, warnings, hints) display.

-- WHY IT EXISTS
-- -------------
-- Default Neovim diagnostics can be noisy.
-- We prefer:
-- - clean UI (no inline spam)
-- - clear float when needed
-- - predictable behavior

-- HOW IT WORKS
-- ------------
-- - disables virtual text by default
-- - enables signs and underline
-- - uses rounded float with source info

-- FLOW
-- ----
-- 1. LSP publishes diagnostics
-- 2. Neovim renders signs + underline
-- 3. User opens float or toggles inline text

vim.diagnostic.config({
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,

	-- OFF by default (clean look)
	virtual_text = false,

	float = {
		border = "rounded",
		source = "always",
	},
})

------------------------------------------
-- DISABLE MINI.INDENTSCOPE IN NEO-TREE
------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
