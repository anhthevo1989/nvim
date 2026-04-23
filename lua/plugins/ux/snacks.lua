--[[
===============================================================================
FILE: lua/plugins/ux/snacks.lua
===============================================================================

PURPOSE
-------
Configure Snacks UX system (core modules).

ENABLED MODULES
---------------
- picker (file/search navigation)
- terminal (integrated shell)
- input (UI prompts)
- notifier (notifications)

NOTES
-----
- This builds the full UX foundation
- Noice will later take over advanced UI
- Keep config minimal for now

===============================================================================
--]]

return {

  {
    "folke/snacks.nvim",

    lazy = true,

    opts = {

      picker = { enabled = true },
      terminal = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },

    },

    config = function(_, opts)
      local snacks = require("snacks")
      snacks.setup(opts)

      -- ===================================================
      -- FORCE SNACKS TO HANDLE INPUT + SELECT
      -- ===================================================

      vim.ui.input = snacks.input
      vim.ui.select = snacks.select
    end,

    keys = {

      { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find files" },
      { "<leader>fg", function() require("snacks").picker.grep() end, desc = "Grep search" },
      { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Find buffers" },
      { "<leader>tt", function() require("snacks").terminal.toggle() end, desc = "Toggle terminal" },

    },

  },

}
