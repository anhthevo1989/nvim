--[[
===============================================================================
FILE: lua/plugins/core/treesitter.lua
===============================================================================

PURPOSE
-------
Declare Treesitter plugin.

WHY THIS FILE EXISTS
--------------------
- Keeps plugin declaration separate from config
- Maintains clean architecture

HOW IT WORKS
------------
- lazy.nvim loads this spec
- Treesitter installs parsers via :TSUpdate

===============================================================================
--]]

return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

}
