--[[
===============================================================================
FILE: lua/plugins/editing/mini-ai.lua
===============================================================================

PURPOSE
-------
Enhance text objects for smarter editing.

WHAT IT DOES
------------
- Improves "inside" and "around" selections
- Makes editing more intuitive and powerful

EXAMPLES
--------
ci"   → change inside quotes
da(   → delete around parentheses
vi{   → select inside braces

===============================================================================
--]]

return {

  {
    "echasnovski/mini.ai",

    version = false,

    opts = {},

  },

}
