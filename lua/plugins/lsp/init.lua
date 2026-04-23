-- ==========================================================
-- FILE: lua/plugins/lsp/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Language Server Protocol (LSP) setup
--
-- WHAT THIS DOES
-- --------------
-- - Installs LSP servers via Mason
-- - Automatically configures them
-- - Connects LSP to nvim-cmp
-- - Uses modern Neovim (0.11+) API
--
-- SERVERS INCLUDED
-- ----------------
-- - lua_ls  (Lua)
-- - bashls  (Bash)
--
-- BEGINNER NOTES
-- --------------
-- This is the brain of autocomplete.
-- Without this, completion is just text matching.
-- ==========================================================

return {
  {
    "neovim/nvim-lspconfig",

    -- Load when opening files
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      -- CMP integration
      "hrsh7th/cmp-nvim-lsp",

      -- Mason (LSP installer)
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
          require("mason").setup()
        end,
      },

      -- Mason bridge to LSP
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "lua_ls",
              "bashls",
            },
          })
        end,
      },
    },

    config = function()
      local cmp_lsp = require("cmp_nvim_lsp")

      -- Capabilities for autocomplete
      local capabilities = cmp_lsp.default_capabilities()

      -- Mason handler to auto-configure all servers
      require("mason-lspconfig").setup({
        handlers = {
          function(server)
            vim.lsp.config(server, {
              capabilities = capabilities,
            })

            vim.lsp.enable(server)
          end,
        },
      })
    end,
  },
}
