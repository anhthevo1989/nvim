-- ==========================================================
-- FILE: lua/plugins/completion/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Completion system with LSP + snippets
--
-- WHAT THIS DOES
-- --------------
-- - Provides autocomplete UI (nvim-cmp)
-- - Integrates LSP suggestions
-- - Adds snippet support (LuaSnip)
-- - Prioritizes intelligent suggestions over buffer text
--
-- BEGINNER NOTES
-- --------------
-- This file controls how autocomplete behaves.
-- Order of sources = importance.
-- ==========================================================

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },

    config = function()
      local cmp = require("cmp")

      cmp.setup({

        -- 🔥 THIS IS THE KEY FIX
        completion = {
          autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },

      })
    end,
  },
}
