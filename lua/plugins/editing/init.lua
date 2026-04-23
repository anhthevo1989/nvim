--[[
===============================================================================
FILE: lua/plugins/editing/init.lua
===============================================================================

PURPOSE
-------
Load all editing-related plugins.

===============================================================================
--]]

return {

  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },

  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup()
    end,
  },

}
