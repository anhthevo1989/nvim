-- ==========================================================
-- FILE: lua/core/init.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Load all core configuration modules.
--
-- WHY IT EXISTS
-- -------------
-- Keeps startup predictable by ensuring foundational
-- systems load in a consistent order.
--
-- HOW IT WORKS
-- ------------
-- Requires each core module in sequence.
--
-- FLOW
-- ----
-- globals
-- → options
-- → keymaps
-- → autocmds
-- → diagnostics
-- → theme
-- → update system
--
-- BEGINNER NOTES
-- --------------
-- Load order matters.
--
-- Globals should load first because other modules may
-- depend on them.
-- ==========================================================

------------------------------------------
-- GLOBALS
------------------------------------------

require("core.globals")

------------------------------------------
-- OPTIONS
------------------------------------------

require("core.options")

------------------------------------------
-- KEYMAPS
------------------------------------------

require("core.keymaps")

------------------------------------------
-- AUTOCOMMANDS
------------------------------------------

require("core.autocmds")

------------------------------------------
-- DIAGNOSTICS
------------------------------------------

require("core.diagnostics")

------------------------------------------
-- THEME
------------------------------------------

require("theme.apply").apply("dark")

------------------------------------------
-- UPDATE SYSTEM
------------------------------------------

require("core.update").setup()
