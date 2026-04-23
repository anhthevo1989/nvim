--[[
===============================================================================
FILE: lua/plugins/completion/init.lua
===============================================================================
PURPOSE
-------
Provide autocompletion system using nvim-cmp.
===============================================================================
--]]

-- SAFE MINIMAL CMP CONFIG (NO DEBUG, NO TRICKS)

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },

    config = function()
      local cmp = require("cmp")

      vim.opt.completeopt = { "menu", "menuone", "noinsert" }

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = {
          { name = "buffer", keyword_length = 1 },
          { name = "path" },
        },
      })
    end,
  },
}
