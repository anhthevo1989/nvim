--[[
===============================================================================
FILE: lua/plugins/core/treesitter.lua
===============================================================================

PURPOSE
-------
Declare Treesitter plugin and Treesitter textobjects.

WHY THIS FILE EXISTS
--------------------
- Keeps plugin declaration separate from config
- Maintains clean architecture
- Adds textobjects support for structural selection

HOW IT WORKS
------------
- lazy.nvim loads this spec
- Treesitter installs parsers via :TSUpdate
- textobjects enables function/class selections

===============================================================================
--]]

return {

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},

		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			require("config.treesitter").setup_textobjects()
		end,
	},
}
