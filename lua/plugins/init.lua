-- ==========================================================
-- FILE: lua/plugins/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Bootstrap lazy.nvim and register plugin groups
--
-- WHY IT EXISTS
-- -------------
-- This file is the plugin system entrypoint.
-- It installs lazy.nvim if needed and tells lazy.nvim which
-- plugin folders to load.
--
-- HOW IT WORKS
-- ------------
-- The lazy.nvim path is checked first.
-- If lazy.nvim is missing, it is cloned into Neovim's data path.
-- Then lazy.nvim loads each plugin group through import specs.
--
-- FLOW
-- ----
-- Neovim starts
-- → this file bootstraps lazy.nvim
-- → plugin groups are registered
-- → lazy.nvim loads each plugin module
--
-- BEGINNER NOTES
-- --------------
-- This file should only wire plugin modules together.
-- Individual plugin configuration belongs inside the matching
-- plugin folder.
--
-- Do not put plugin setup logic directly in this file.
-- ==========================================================

-- ==========================================================
-- BOOTSTRAP LAZY.NVIM
-- ==========================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- ==========================================================
-- PLUGIN REGISTRATION
-- ==========================================================

require("lazy").setup({

	spec = {

		-- ------------------------------------------------------
		-- NAVIGATION
		-- ------------------------------------------------------
		{ import = "plugins.navigation" },

		-- ------------------------------------------------------
		-- UX
		-- ------------------------------------------------------
		{ import = "plugins.ux" },

		-- ------------------------------------------------------
		-- EDITING
		-- ------------------------------------------------------
		{ import = "plugins.editing" },

		-- ------------------------------------------------------
		-- COMPLETION
		-- ------------------------------------------------------
		{ import = "plugins.completion" },

		-- ------------------------------------------------------
		-- TREESITTER
		-- ------------------------------------------------------
		{ import = "plugins.treesitter" },

		-- ------------------------------------------------------
		-- LSP
		-- ------------------------------------------------------
		{ import = "plugins.lsp" },

		-- ------------------------------------------------------
		-- FORMATTING
		-- ------------------------------------------------------
		{ import = "plugins.formatting" },

		-- ------------------------------------------------------
		-- DEBUGGING
		-- ------------------------------------------------------
		{ import = "plugins.debug" },
		{ import = "plugins.debug.ui" },
		{ import = "plugins.debug.virtual_text" },

		-- ------------------------------------------------------
		-- SCREEN LAYOUT
		-- ------------------------------------------------------
		{ import = "plugins.layout" },

		-- ------------------------------------------------------
		-- UI
		-- ------------------------------------------------------
		{ import = "plugins.ui" },

		-- ------------------------------------------------------
		-- TOOLS
		-- ------------------------------------------------------
		{ import = "plugins.tools" },
	},
})
