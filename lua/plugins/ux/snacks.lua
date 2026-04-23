--[[
===============================================================================
FILE: lua/plugins/ux/snacks.lua
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

      -- --------------------------------------------------
      -- KEY HINTS
      -- --------------------------------------------------

      scope = {
        enabled = true,
      },

    },

    config = function(_, opts)
      local snacks = require("snacks")
      snacks.setup(opts)

      -- UI overrides (temporary until Noice)
      vim.ui.input = snacks.input
      vim.ui.select = snacks.select
    end,

    keys = {

      -- FILE SEARCH
      { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find files" },

      -- GREP
      { "<leader>fg", function() require("snacks").picker.grep() end, desc = "Grep search" },

      -- BUFFERS
      { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Find buffers" },

      -- TERMINAL
      { "<leader>tt", function() require("snacks").terminal.toggle() end, desc = "Toggle terminal" },

    },

  },

}
