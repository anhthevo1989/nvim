#!/bin/sh
# ==========================================================
# FILE: install.sh
# ==========================================================
#
# PURPOSE
# -------
# Install this Neovim configuration in a safe and repeatable way.
#
# WHY IT EXISTS
# -------------
# Users should be able to install the config without guessing which
# packages are needed or where files will be placed.
#
# HOW IT WORKS
# ------------
# The script installs system packages first, then installs Python
# workflow tools into a dedicated virtual environment, then installs
# Lua workflow tools through LuaRocks, then installs the config.
#
# FLOW
# ----
# 1. Detect the operating system and package manager.
# 2. Choose the install layout.
# 3. Install system dependencies.
# 4. Install Python and Lua workflow dependencies.
# 5. Back up existing Neovim files.
# 6. Clone or repair the repository.
# 7. Link the config when using symlink mode.
# 8. Verify the installation.
#
# BEGINNER NOTES
# --------------
# Do not run this script as root.
#
# Python packages are installed into:
# ~/.local/share/nvim-python-tools
#
# This avoids modifying the system Python installation.
# ==========================================================

set -eu

# ==========================================================
# CONFIGURATION
# ==========================================================

REPO_URL="https://github.com/anhthevo1989/nvim"
DEFAULT_CONFIG_DIR="$HOME/.config/nvim"
DEFAULT_REPO_DIR="$HOME/Projects/nvim"
PYTHON_TOOLS_DIR="$HOME/.local/share/nvim-python-tools"

STAMP="$(date +%Y%m%d-%H%M%S)"
TOTAL_STEPS=8
CURRENT_STEP=0

INSTALL_MODE="symlink"
CONFIG_DIR="$DEFAULT_CONFIG_DIR"
REPO_DIR="$DEFAULT_REPO_DIR"

SKIP_DEPS=0
DRY_RUN=0
REPAIR=0
NON_INTERACTIVE=0

# ==========================================================
# COLORS
# ==========================================================

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
	RED="$(printf '\033[31m')"
	GREEN="$(printf '\033[32m')"
	YELLOW="$(printf '\033[33m')"
	CYAN="$(printf '\033[36m')"
	BOLD="$(printf '\033[1m')"
	RESET="$(printf '\033[0m')"
else
	RED=""
	GREEN=""
	YELLOW=""
	CYAN=""
	BOLD=""
	RESET=""
fi

# ==========================================================
# OUTPUT HELPERS
# ==========================================================

say() { printf '%s\n' "$1"; }
ok() { printf '%s%s%s\n' "$GREEN" "✔ $1" "$RESET"; }
warn() { printf '%s%s%s\n' "$YELLOW" "⚠ $1" "$RESET"; }
fail() { printf '%s%s%s\n' "$RED" "✘ $1" "$RESET"; exit 1; }

step() {
	CURRENT_STEP=$((CURRENT_STEP + 1))
	printf '\n%s[%s/%s] %s%s\n' "$CYAN" "$CURRENT_STEP" "$TOTAL_STEPS" "$1" "$RESET"
}

# ==========================================================
# COMMAND HELPERS
# ==========================================================

has() { command -v "$1" >/dev/null 2>&1; }

run() {
	if [ "$DRY_RUN" -eq 1 ]; then
		printf '%s\n' "DRY RUN: $*"
	else
		"$@"
	fi
}

expand_path() {
	case "$1" in
		"~") EXPANDED_PATH="$HOME" ;;
		"~/"*) EXPANDED_PATH="$HOME/$(printf '%s\n' "$1" | sed 's|^~/||')" ;;
		*) EXPANDED_PATH="$1" ;;
	esac
}

# ==========================================================
# HELP TEXT
# ==========================================================

usage() {
	cat <<USAGE
Neovim installer

Usage:
  sh install.sh [options]

Options:
  --dry-run          Print actions without changing anything
  --skip-deps        Skip system, Python, and LuaRocks dependency installation
  --repair           Pull latest repo if it already exists
  --non-interactive  Use defaults without prompting
  --help             Show this help

Default layout:
  Repo:   $DEFAULT_REPO_DIR
  Config: $DEFAULT_CONFIG_DIR
USAGE
}

# ==========================================================
# ARGUMENT PARSING
# ==========================================================

while [ "$#" -gt 0 ]; do
	case "$1" in
		--dry-run) DRY_RUN=1 ;;
		--skip-deps) SKIP_DEPS=1 ;;
		--repair) REPAIR=1 ;;
		--non-interactive) NON_INTERACTIVE=1 ;;
		--help|-h) usage; exit 0 ;;
		*) fail "Unknown option: $1" ;;
	esac
	shift
done

# ==========================================================
# SAFETY CHECKS
# ==========================================================

if [ "$(id -u)" -eq 0 ]; then
	fail "Do not run this script as root. It will ask for sudo when needed."
fi

# ==========================================================
# SYSTEM DETECTION
# ==========================================================

detect_package_manager() {
	if has pacman; then PM="pacman"
	elif has apt-get; then PM="apt"
	elif has dnf; then PM="dnf"
	elif has zypper; then PM="zypper"
	elif has xbps-install; then PM="xbps"
	elif has apk; then PM="apk"
	elif has emerge; then PM="emerge"
	elif has brew; then PM="brew"
	elif has nix; then PM="nix"
	else PM="unknown"
	fi
}

detect_operating_system() {
	OS_NAME="$(uname -s)"
	if [ -r /etc/os-release ]; then
		OS_NAME="$(sed -n 's/^PRETTY_NAME=//p' /etc/os-release | tr -d '"' | sed -n '1p')"
	fi
	if [ -r /proc/version ] && grep -qi "microsoft\|wsl" /proc/version; then
		OS_NAME="$OS_NAME (WSL)"
	fi
}

# ==========================================================
# INSTALL LAYOUT
# ==========================================================

choose_install_paths() {
	if [ "$NON_INTERACTIVE" -eq 1 ] || [ ! -t 0 ]; then return; fi

	say ""
	say "Choose install mode:"
	say "  1) Standard - clone directly to the Neovim config path"
	say "  2) Symlink  - clone repo elsewhere and link it to Neovim config path"
	printf '%s' "Select [1/2] (default: 2): "
	read choice

	case "$choice" in
		1) INSTALL_MODE="standard" ;;
		""|2) INSTALL_MODE="symlink" ;;
		*) fail "Invalid install mode." ;;
	esac

	say ""
	say "Neovim config path:"
	say "Press Enter to use default:"
	say "  $DEFAULT_CONFIG_DIR"
	printf '%s' "> "
	read config_input

	if [ -n "$config_input" ]; then
		expand_path "$config_input"
		CONFIG_DIR="$EXPANDED_PATH"
	fi

	if [ "$INSTALL_MODE" = "standard" ]; then
		REPO_DIR="$CONFIG_DIR"
		return
	fi

	say ""
	say "Repo clone path:"
	say "Press Enter to use default:"
	say "  $DEFAULT_REPO_DIR"
	printf '%s' "> "
	read repo_input

	if [ -n "$repo_input" ]; then
		expand_path "$repo_input"
		REPO_DIR="$EXPANDED_PATH"
	fi
}

confirm_install() {
	if [ "$NON_INTERACTIVE" -eq 1 ] || [ ! -t 0 ]; then return; fi
	printf '%s' "Continue? [Y/n]: "
	read confirm
	case "$confirm" in ""|y|Y|yes|YES) ;; *) fail "Cancelled." ;; esac
}

# ==========================================================
# SYSTEM DEPENDENCIES
# ==========================================================

install_system_dependencies() {
	if [ "$SKIP_DEPS" -eq 1 ]; then warn "Skipping system dependency installation."; return; fi

	case "$PM" in
		pacman)
			run sudo pacman -S --needed base-devel neovim git ripgrep fd lazygit nodejs npm python python-pip python-virtualenv lua luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli
			;;
		apt)
			run sudo apt-get update
			run sudo apt-get install -y build-essential neovim git ripgrep fd-find lazygit nodejs npm python3 python3-pip python3-venv lua5.4 luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli
			;;
		dnf)
			run sudo dnf install -y @development-tools neovim git ripgrep fd-find lazygit nodejs npm python3 python3-pip python3-virtualenv lua luajit luarocks luacheck bash bats ShellCheck shfmt tree-sitter-cli
			;;
		zypper)
			run sudo zypper install -y -t pattern devel_basis
			run sudo zypper install -y neovim git ripgrep fd lazygit nodejs npm python3 python3-pip python3-virtualenv lua54 luajit luarocks luacheck bash bats ShellCheck shfmt tree-sitter
			;;
		xbps)
			run sudo xbps-install -Sy base-devel neovim git ripgrep fd lazygit nodejs npm python3 python3-pip python3-virtualenv lua LuaJIT luarocks luacheck bash bats ShellCheck shfmt tree-sitter
			;;
		apk)
			run sudo apk add build-base neovim git ripgrep fd lazygit nodejs npm python3 py3-pip py3-virtualenv lua5.4 luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli
			;;
		emerge)
			run sudo emerge --ask=n app-editors/neovim dev-vcs/git sys-apps/ripgrep sys-apps/fd dev-lang/python net-libs/nodejs dev-lang/lua dev-lang/luajit dev-lua/luarocks dev-util/shellcheck app-shells/bash
			warn "Gentoo package names vary. Install lazygit, bats, shfmt, luacheck, and tree-sitter-cli manually if missing."
			;;
		brew)
			run brew install neovim git ripgrep fd lazygit node python lua luajit luarocks luacheck bash bats-core shellcheck shfmt tree-sitter
			;;
		nix)
			run nix profile install nixpkgs#neovim nixpkgs#git nixpkgs#ripgrep nixpkgs#fd nixpkgs#lazygit nixpkgs#nodejs nixpkgs#python3 nixpkgs#lua nixpkgs#luajit nixpkgs#luarocks nixpkgs#luacheck nixpkgs#bash nixpkgs#bats nixpkgs#shellcheck nixpkgs#shfmt nixpkgs#tree-sitter
			;;
		*)
			fail "Unsupported package manager. Install dependencies manually, then rerun with --skip-deps."
			;;
	esac
}

# ==========================================================
# LANGUAGE WORKFLOW DEPENDENCIES
# ==========================================================

find_python_command() {
	if has python3; then PYTHON_CMD="python3"
	elif has python; then PYTHON_CMD="python"
	else fail "Python is required but was not found."
	fi
}

install_python_dependencies() {
	if [ "$SKIP_DEPS" -eq 1 ]; then warn "Skipping Python workflow dependency installation."; return; fi
	find_python_command
	if [ ! -d "$PYTHON_TOOLS_DIR" ]; then
		run "$PYTHON_CMD" -m venv "$PYTHON_TOOLS_DIR"
	fi
	run "$PYTHON_TOOLS_DIR/bin/python" -m pip install --upgrade pip
	run "$PYTHON_TOOLS_DIR/bin/python" -m pip install debugpy pytest
	ok "Installed Python workflow tools in $PYTHON_TOOLS_DIR"
}

install_lua_dependencies() {
	if [ "$SKIP_DEPS" -eq 1 ]; then warn "Skipping Lua workflow dependency installation."; return; fi
	if ! has luarocks; then fail "LuaRocks is required but was not found."; fi
	run luarocks install --local busted
	ok "Installed Lua workflow tool: busted"
}

install_language_dependencies() {
	install_python_dependencies
	install_lua_dependencies
	warn "Make sure this user-local LuaRocks bin directory is on PATH when needed:"
	say "  $HOME/.luarocks/bin"
}

# ==========================================================
# BACKUP
# ==========================================================

backup_path() {
	path="$1"
	if [ -e "$path" ] || [ -L "$path" ]; then
		backup="$path.bak.$STAMP"
		run mv "$path" "$backup"
		ok "Backed up $path -> $backup"
	else
		ok "No existing $path found"
	fi
}

# ==========================================================
# REPOSITORY INSTALL
# ==========================================================

prepare_directories() {
	run mkdir -p "$(dirname "$REPO_DIR")"
	run mkdir -p "$(dirname "$CONFIG_DIR")"
}

clone_or_repair_repository() {
	if [ -d "$REPO_DIR/.git" ]; then
		ok "Repo already exists at $REPO_DIR"
		if [ "$REPAIR" -eq 1 ]; then run git -C "$REPO_DIR" pull --ff-only; else warn "Use --repair to pull the latest changes."; fi
		return
	fi
	if [ -e "$REPO_DIR" ]; then fail "$REPO_DIR exists but is not a git repository."; fi
	run git clone "$REPO_URL" "$REPO_DIR"
}

link_config_directory() {
	if [ "$INSTALL_MODE" = "symlink" ]; then
		run ln -sfn "$REPO_DIR" "$CONFIG_DIR"
		ok "Linked $CONFIG_DIR -> $REPO_DIR"
	fi
}

# ==========================================================
# VERIFY
# ==========================================================

verify_command() {
	command_name="$1"
	display_name="$2"
	if has "$command_name"; then ok "$display_name"; else warn "Missing: $display_name"; VERIFY_MISSING=1; fi
}

verify_installation() {
	VERIFY_MISSING=0
	find_python_command

	verify_command nvim "nvim"
	verify_command git "git"
	verify_command lazygit "lazygit"
	verify_command rg "ripgrep"
	verify_command node "node"
	verify_command npm "npm"
	verify_command luarocks "luarocks"
	verify_command luacheck "luacheck"
	verify_command bash "bash"
	verify_command bats "bats"
	verify_command shellcheck "shellcheck"
	verify_command shfmt "shfmt"

	if has fd || has fdfind; then ok "fd/fdfind"; else warn "Missing: fd/fdfind"; VERIFY_MISSING=1; fi
	if has tree-sitter; then ok "tree-sitter"; else warn "Missing: tree-sitter"; VERIFY_MISSING=1; fi
	if has python3 || has python; then ok "python"; else warn "Missing: python"; VERIFY_MISSING=1; fi
	if has pip3 || has pip; then ok "pip"; else warn "Missing: pip"; VERIFY_MISSING=1; fi

	if [ -x "$PYTHON_TOOLS_DIR/bin/python" ] && "$PYTHON_TOOLS_DIR/bin/python" -c "import debugpy" >/dev/null 2>&1; then ok "debugpy"; else warn "Missing: debugpy"; VERIFY_MISSING=1; fi
	if [ -x "$PYTHON_TOOLS_DIR/bin/python" ] && "$PYTHON_TOOLS_DIR/bin/python" -c "import pytest" >/dev/null 2>&1; then ok "pytest"; else warn "Missing: pytest"; VERIFY_MISSING=1; fi
	if has busted || [ -x "$HOME/.luarocks/bin/busted" ]; then ok "busted"; else warn "Missing: busted"; VERIFY_MISSING=1; fi

	if [ "$VERIFY_MISSING" -eq 1 ]; then fail "Some required tools are missing."; fi
}

# ==========================================================
# MAIN
# ==========================================================

say "${BOLD}Neovim Installer${RESET}"
say "A readable installer for a full-stack Neovim environment."

step "Detecting system"
detect_operating_system
detect_package_manager
say "OS: $OS_NAME"
say "Package manager: $PM"

step "Choosing install layout"
choose_install_paths
say "Mode: $INSTALL_MODE"
say "Repo: $REPO_DIR"
say "Config: $CONFIG_DIR"
confirm_install

step "Installing system dependencies"
install_system_dependencies

step "Installing language dependencies"
install_language_dependencies

step "Preparing directories"
prepare_directories

step "Backing up existing Neovim files"
backup_path "$CONFIG_DIR"
backup_path "$HOME/.local/share/nvim"
backup_path "$HOME/.local/state/nvim"
backup_path "$HOME/.cache/nvim"

step "Cloning repository"
clone_or_repair_repository
link_config_directory

step "Verifying install"
verify_installation

say ""
ok "Installation complete."
say "Restart your shell, then run: nvim"
