-- ==========================================================
-- PLUGIN SYSTEM
-- ==========================================================

-- PURPOSE
-- -------
-- Initialize and manage plugins using lazy.nvim

-- WHY IT EXISTS
-- -------------
-- Neovim does not include a built-in plugin manager.
-- This file installs and configures lazy.nvim.

-- HOW IT WORKS
-- ------------
-- 1. Check if lazy.nvim exists locally
-- 2. Clone it if missing
-- 3. Add it to runtime path
-- 4. Initialize plugin system

-- FLOW
-- ----
-- startup
-- → check lazy.nvim
-- → install if missing
-- → load plugin system
-- → register plugins

-- BEGINNER NOTES
-- --------------
-- This file controls ALL plugins.
-- Only declare plugins here during early phases.
-- Do NOT configure plugins yet.

-- ==========================================================
-- BOOTSTRAP LAZY.NVIM
-- ==========================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ==========================================================
-- PLUGIN REGISTRATION
-- ==========================================================

require("lazy").setup({

  spec = {

    -- ------------------------------------------------------
    -- TREESITTER
    -- ------------------------------------------------------

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },

  },

})
