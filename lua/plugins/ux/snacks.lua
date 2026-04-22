--[[
===============================================================================
FILE: lua/plugins/ux/snacks.lua
===============================================================================

PURPOSE
-------
Configure Snacks UX system (picker enabled).

WHY THIS FILE EXISTS
--------------------
- Enables Snacks picker (fuzzy finder)
- Replaces Telescope functionality
- Provides fast file + search navigation

HOW IT WORKS
------------
- lazy.nvim loads Snacks
- Picker module is enabled via opts
- Keymaps trigger picker actions

FLOW
----
plugins/init.lua
  → plugins.ux
      → snacks.lua
          → enables picker

BEGINNER NOTES
--------------
- Only picker is enabled for now
- Other modules will be added later
- Keep config minimal for easier debugging

===============================================================================
--]]

return {

  {
    "folke/snacks.nvim",

    lazy = true,

    opts = {

      picker = {
        enabled = true,
      },

    },

    keys = {

      -- --------------------------------------------------
      -- FILE SEARCH
      -- --------------------------------------------------

      {
        "<leader>ff",
        function()
          require("snacks").picker.files()
        end,
        desc = "Find files",
      },

      -- --------------------------------------------------
      -- LIVE GREP
      -- --------------------------------------------------

      {
        "<leader>fg",
        function()
          require("snacks").picker.grep()
        end,
        desc = "Grep search",
      },

      -- --------------------------------------------------
      -- BUFFERS
      -- --------------------------------------------------

      {
        "<leader>fb",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "Find buffers",
      },

    },

  },

}
