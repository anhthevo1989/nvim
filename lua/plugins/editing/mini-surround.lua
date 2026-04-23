--[[
===============================================================================
FILE: lua/plugins/editing/mini-surround.lua
===============================================================================

PURPOSE
-------
Enable fast manipulation of surrounding characters.

WHAT IT DOES
------------
- Add, change, delete surrounding pairs
- Works with quotes, brackets, tags, etc.

EXAMPLES
--------
ysiw"   → "word"
cs"'    → "word" → 'word'
ds"     → "word" → word

===============================================================================
--]]

return {
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },
}
