--[[
===============================================================================
FILE: lua/plugins/ux/snacks.lua
===============================================================================

PURPOSE
-------
Declare Snacks plugin (UX system core).

WHY THIS FILE EXISTS
--------------------
Snacks provides a unified UX layer that will replace:
- Telescope (picker)
- Toggleterm (terminal)
- which-key (key hints)
- UI input + notifications

At this stage, we ONLY install the core plugin.

HOW IT WORKS
------------
- lazy.nvim loads the plugin
- No modules are enabled yet
- This ensures a clean baseline before adding features

FLOW
----
plugins/init.lua
  → imports plugins.ux
      → loads this file
          → registers Snacks

BEGINNER NOTES
--------------
- Do NOT enable any Snacks features yet
- We will enable features step-by-step
- This keeps debugging simple

===============================================================================
--]]

return {
  {
    "folke/snacks.nvim",
    lazy = true,
    opts = {},
  },
}
