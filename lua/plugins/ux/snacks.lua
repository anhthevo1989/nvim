--[[
===============================================================================
FILE: lua/plugins/ux/snacks.lua
===============================================================================

PURPOSE
-------
Configure Snacks UX system (picker + terminal).

WHY THIS FILE EXISTS
--------------------
- Enables fuzzy finder (picker)
- Adds integrated terminal
- Builds core UX layer

HOW IT WORKS
------------
- Snacks loads modules via opts
- Picker handles navigation
- Terminal provides shell inside Neovim

FLOW
----
plugins/init.lua
  → plugins.ux
      → snacks.lua
          → enables picker + terminal

BEGINNER NOTES
--------------
- Only picker + terminal enabled
- Other modules added later
- Keep configuration minimal

===============================================================================
--]]

return {

  {
    "folke/snacks.nvim",

    lazy = true,

    opts = {

      -- --------------------------------------------------
      -- PICKER
      -- --------------------------------------------------

      picker = {
        enabled = true,
      },

      -- --------------------------------------------------
      -- TERMINAL
      -- --------------------------------------------------

      terminal = {
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
      -- GREP SEARCH
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

      -- --------------------------------------------------
      -- TERMINAL TOGGLE
      -- --------------------------------------------------

      {
        "<leader>tt",
        function()
          require("snacks").terminal.toggle()
        end,
        desc = "Toggle terminal",
      },

    },

  },

}
