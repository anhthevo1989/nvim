ROADMAP
=======

PURPOSE
-------

- Define the future direction of the Neovim project.
- Keep planned features organized in dependency-safe order.
- Communicate development priorities clearly for both the maintainer and users.

WHY IT EXISTS
-------------

- Public projects need visible direction.
- A roadmap helps track what is planned next.
- It prevents feature creep by keeping priorities intentional.
- It gives users visibility into what is coming without making promises based on version numbers.

HOW IT WORKS
------------

- Features are grouped by purpose.
- Workflow improvements are prioritized first.
- UX and quality-of-life features follow after core functionality.
- Infrastructure and documentation improvements support long-term maintainability.

FLOW
----

1. Expand development workflows
2. Improve parser and language tooling
3. Improve UX and accessibility
4. Improve customization
5. Improve product polish
6. Improve project documentation

BEGINNER NOTES
--------------

- This project uses a rolling release model.
- `main` is always considered the latest stable version.
- Features are added only after they are built, tested, and validated.
- Bug fixes are patched and pushed immediately.
- `CHANGELOG.md` is maintained continuously and tracks changes pushed to `main`.

WORKFLOW EXPANSION
------------------

### 1) Full C# Support
**Branch:** `feature/csharp-support`

- Add C# LSP support
- Add debugging support
- Add formatting support
- Add `dotnet test`
- Add run/test adapters
- Add Treesitter parser support
- Update installers
- Update documentation

**Why this matters:**

- Expands Neovim into a stronger game development environment.
- Benefits both personal workflows and public users.

---

### 2) Treesitter UI Panel
**Branch:** `feature/treesitter-panel`

Command:

`:TSManager`

Features:

- View installed parsers
- Browse available parsers
- Install parsers
- Remove parsers
- Update parsers
- Parser health checks

**Why this matters:**

- Makes parser management easier for newer users.
- Improves Treesitter usability significantly.

UX & ACCESSIBILITY
------------------

### 3) Right-Click Menu
**Branch:** `feature/right-click-menu`

Features:

- Copy
- Cut
- Paste
- Select All
- Run File
- Run Nearest Test
- LSP submenu
- Debug submenu

Advanced UX:

- Double-click word select
- Triple-click line select
- Collapsible menus
- Mouse wheel navigation

**Why this matters:**

- Makes Neovim more accessible for mouse-first users.
- Creates a more IDE-like workflow.

---

### 4) Alt-Mode
**Branch:** `feature/alt-mode`

Dashboard toggle:

- Classic Mode
- Alt-Mode

Alt shortcuts:

- Alt+Z → Undo
- Alt+X → Cut
- Alt+C → Copy
- Alt+V → Paste
- Alt+A → Select All
- Alt+S → Save
- Alt+Y → Redo

**Why Alt instead of Ctrl?**

- Ctrl is heavily used by terminal emulators.
- Alt provides more consistent cross-terminal behavior.

**Why this matters:**

- Helps users coming from traditional editors.
- Makes Neovim easier to adopt.

CUSTOMIZATION
-------------

### 5) Theme Manager
**Branch:** `feature/theme-manager`

Command:

`:ThemeManager`

Built-in support:

- Pulse Dark
- Pulse Light
- Pulse High Contrast
- Built-in Neovim themes

External theme support:

- Install themes
- Remove themes
- Update themes
- Favorites
- Persistence
- Live previews

**Why this matters:**

- Adds flexibility without bloating the config.

POLISH & QUALITY OF LIFE
------------------------

### 6) Pulse-Themed Install/Uninstall Scripts
**Branch:** `feature/pulse-script-ui`

Features:

- Shared Pulse color library
- Consistent UI messaging
- Progress indicators
- Cleaner uninstall flow
- Matching installer UX

**Why this matters:**

- Improves first impressions.
- Makes scripts feel more productized.

---

### 7) UndoTree Integration
**Branch:** `feature/undotree`

Features:

- Persistent undo history
- Visual undo timeline
- Pulse styling
- Keymap integration

**Why this matters:**

- Adds workflow quality-of-life improvements.

---

### 8) Language-Specific Single Init Files
**Branch:** `feature/language-init`

Examples:

- `examples/python/init.lua`
- `examples/lua/init.lua`
- `examples/shell/init.lua`
- `examples/csharp/init.lua`

Features:

- Standalone language-focused configs
- Workflow-specific setup examples
- Easier onboarding
- Portable learning examples
- Cleaner adoption for users who do not need the full stack

**Why this matters:**

- Makes language workflows easier to learn.
- Gives users lighter entry points into the project.
- Improves portability without changing the main config.

PROJECT INFRASTRUCTURE
----------------------

### 9) Documentation Style Guide Compliance
**Branch:** `docs/style-guide-compliance`

Scope:

- README.md
- INSTALL.md
- UNINSTALL.md
- KEYMAPS.md
- CHANGELOG.md
- docs/
- script docs
- file headers

Features:

- Update docs to new style guide
- Ensure beginner readability
- Ensure repo-wide consistency

**Why this matters:**

- Makes documentation easier to follow.
- Improves long-term maintainability.

FINAL GOAL
----------

- Build a Neovim configuration that is:

  - Workflow-focused
  - Beginner-friendly
  - Highly customizable
  - Visually cohesive
  - Well documented
  - Stable enough for daily development

- Every roadmap item must be:

  - Built
  - Tested
  - Validated
  - Merged into `dev`
  - Approved before pushing to `main`
