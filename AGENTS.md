# AGENTS.md

## Build/Run Commands
- `stow */` - Symlink all dotfiles; `stow <dir>` for individual packages
- `task ansible` - Run Ansible playbook to install and configure
- `task sketchybar-plugins` - Build Go plugins: `go build -o aerospace ./aerospace.go`

## Code Style

### Lua (Neovim, Hammerspoon)
- Use `require()` for imports; organize config modules under `lua/config/` and `lua/plugins/`
- Use `vim.keymap.set()` for keymaps with `desc` for documentation
- No comments unless necessary; code should be self-documenting

### Go (Sketchybar plugins)
- Standard library imports first, then external packages
- Use `const` blocks for related constants; use descriptive `icon_*` naming
- Handle errors with `log.Fatal()` for critical failures
- Use early returns and guard clauses

### Shell Scripts
- Use `#!/bin/bash` or `#!/bin/zsh` shebang
- Follow existing patterns in `bin/` directory

### General
- This is a stow-based dotfiles repo; each top-level dir is a stow package
- Config files go in `.config/<app>/` within each package dir
- Prefer existing patterns and conventions found in neighboring files
