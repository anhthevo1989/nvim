--[[
===============================================================================
FILE: lua/plugins/navigation/nvim-tree.lua
===============================================================================

PURPOSE
-------
Declare and configure the nvim-tree plugin.

WHY THIS FILE EXISTS
--------------------
This file:
- Registers nvim-tree as a plugin
- Defines its dependencies
- Sets up basic configuration

This is the file explorer for the editor.

HOW IT WORKS
------------
- lazy.nvim loads this plugin when needed
- The config function runs after the plugin loads
- Minimal configuration is applied for stability

FLOW
----
plugins/init.lua
  → imports plugins.navigation
      → loads this file
          → registers nvim-tree

BEGINNER NOTES
--------------
- This file ONLY handles nvim-tree
- Do NOT put unrelated plugins here
- Keep configuration minimal during build phase

===============================================================================
--]]

return {

  -- ==========================================================================
  -- NVIM-TREE PLUGIN
  -- ==========================================================================

  {
    "nvim-tree/nvim-tree.lua",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus",
    },

    keys = {
      {
        "<leader>e",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Toggle file explorer",
      },
    },

    config = function()
      require("nvim-tree").setup({

        -- ================================================================
        -- CORE SETTINGS
        -- ================================================================

        disable_netrw = true,
        hijack_netrw = true,

        -- ================================================================
        -- VIEW SETTINGS
        -- ================================================================

        view = {
          width = 30,
          side = "left",
        },

        -- ================================================================
        -- RENDER SETTINGS
        -- ================================================================

        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },

        -- ================================================================
        -- ACTIONS
        -- ================================================================

        actions = {
          open_file = {
            quit_on_open = false,
          },
        },

      })
    end,
  },

}
