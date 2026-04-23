-- ==========================================================
-- FILE: lua/plugins/completion/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Completion system with snippet support
-- ==========================================================

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      -- SNIPPETS
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      vim.opt.completeopt = { "menu", "menuone", "noinsert" }

      cmp.setup({

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({

          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- TAB: next item OR expand snippet
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          -- SHIFT+TAB: previous item OR jump back
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

        }),

        sources = {
          { name = "luasnip" },
          { name = "buffer", keyword_length = 1 },
          { name = "path" },
        },

      })
    end,
  },
}
