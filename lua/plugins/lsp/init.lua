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
-- - Connects LSP to nvim-cmp
-- - Configures lua_ls for Neovim API awareness
-- - Enables intelligent autocomplete
-- ==========================================================

return {
  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",

      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = true,
      },

      {
        "williamboman/mason-lspconfig.nvim",
        config = true,
      },
    },

    config = function()
      local cmp_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_lsp.default_capabilities()

      -- Ensure servers installed
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      -- 🔥 MODERN API (NO lspconfig.setup)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,

        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },

            diagnostics = {
              globals = { "vim" },
            },

            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },

            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable("lua_ls")
    end,
  },
}
