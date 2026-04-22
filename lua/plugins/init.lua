--[[
===============================================================================
FILE: lua/plugins/init.lua
===============================================================================

PURPOSE
-------
Initialize and manage plugins using lazy.nvim.

WHY THIS FILE EXISTS
--------------------
- Bootstraps lazy.nvim
- Registers plugin groups
- Controls plugin loading

HOW IT WORKS
------------
1. Installs lazy.nvim if missing
2. Adds it to runtime path
3. Loads plugin specifications from lua/plugins/

FLOW
----
startup
→ bootstrap lazy.nvim
→ load plugin groups
→ lazy loads plugins

BEGINNER NOTES
--------------
- DO NOT declare plugins directly here
- Plugins live in subfolders (navigation, editing, etc.)
- This file only loads groups

===============================================================================
--]]

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM
-- ============================================================================

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

-- ============================================================================
-- PLUGIN REGISTRATION
-- ============================================================================

require("lazy").setup({

  spec = {

    -- ------------------------------------------------------
    -- CORE / BASE
    -- ------------------------------------------------------

    { import = "plugins.core" },

    -- ------------------------------------------------------
    -- NAVIGATION
    -- ------------------------------------------------------

    { import = "plugins.navigation" },

    -- ------------------------------------------------------
    -- UX SYSTEM (SNACKS)
    -- ------------------------------------------------------

    { import = "plugins.ux" },

  },

})
