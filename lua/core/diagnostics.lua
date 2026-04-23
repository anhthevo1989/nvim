-- ==========================================================
-- FILE: lua/core/diagnostics.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure how LSP diagnostics (errors, warnings, hints)
-- are displayed in Neovim
--
-- WHAT THIS DOES
-- --------------
-- - Shows inline error text
-- - Adds signs in the gutter
-- - Enables floating popups
-- - Updates diagnostics in real time
--
-- BEGINNER NOTES
-- --------------
-- Diagnostics = errors, warnings, hints from LSP
-- ==========================================================

vim.diagnostic.config({

  -- Show virtual text (inline errors)
  virtual_text = {
    prefix = "●", -- symbol before message
  },

  -- Show signs in gutter
  signs = true,

  -- Underline errors
  underline = true,

  -- Update while typing
  update_in_insert = true,

  -- Sort by severity
  severity_sort = true,

  -- Floating window config
  float = {
    border = "rounded",
    source = "always",
  },
})
