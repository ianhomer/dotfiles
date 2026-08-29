# AGENTS.md

## Project Overview

This is a dotfiles repository for configuring development environments. It uses GNU Stow to symlink configuration files into place and provides shell scripts for installation and ongoing management.

## Repository Structure

```
.dotfiles/
├── bin/              # Utility scripts and the `dotme` command
├── dotfiles/         # Actual dotfile configs organized by tool
│   ├── fish/         # Fish shell configuration
│   ├── zsh/          # Zsh configuration
│   ├── nvim/         # Neovim configuration
│   ├── git/          # Git configuration
│   └── ...           # Other tool configs
├── docs/             # Documentation and cheat sheets
├── test/             # Test suite and fixtures
│   ├── fixtures/     # BATS test files
│   └── os/           # OS-specific installation tests
├── src/              # Source files (pandoc, etc.)
├── start              # Initial installation script
└── README.md
```

## Key Commands

### First-time Setup

```bash
# Clone and install (fresh system)
git clone https://github.com/ianhomer/dotfiles ~/.dotfiles
~/.dotfiles/start
```

### Ongoing Management

```bash
# Update and run administrative actions
dotme

# Get help
dotme -h
man dotme

# Run specific components
dotme brew    # Install/update brew packages
dotme fish    # Configure fish shell
dotme vim     # Configure vim/nvim
dotme git     # Configure git
dotme doctor  # Check system health
```

### Testing

Tests are located in the `test/` directory and use BATS (Bash Automated Testing System).

```bash
# Navigate to test directory
cd test

# Install dependencies
pnpm install

# Run tests
pnpm test                # Run BATS tests
bats -T fixtures         # Direct BATS execution

# Run linting
pnpm lint                # Run ESLint and Prettier
pnpm lint:fix            # Fix linting issues
pnpm prettier            # Check formatting
pnpm prettier:fix        # Fix formatting
```

### Scripts (in `bin/`)

- `dotme` - Main administration command
- `dotme-start` - Bootstrap script
- `dotme-brew` - Homebrew package management
- `dotme-apps` - Application installation
- `backup-me` - Backup script
- Various utility functions in `bin/functions/`

## Conventions

### File Organization

- Each tool's dotfiles live in `dotfiles/<tool>/`
- Use GNU Stow structure: `dotfiles/<tool>/.<path>/<to>/<config>`
- Binary scripts go in `bin/` and should be executable

### Shell Scripts

- Use `#!/usr/bin/env bash` or `#!/usr/bin/env sh` shebang
- Include `set -e` for error handling where appropriate
- Use the logging functions in `bin/functions/log.sh`

### Configuration Files

- Fish: `dotfiles/fish/.config/fish/`
- Zsh: `dotfiles/zsh/.zshrc`
- Neovim: `dotfiles/nvim/.config/nvim/`
- Git: `dotfiles/git/.gitconfig`

## Local Customization

Create `~/.config/dotme/.env` for local overrides:

```properties
MY_NOTES=my-notes
```

## Pre-commit Hooks

The repository has pre-commit and pre-push hooks in `.hooks/`. These run automatically when committing.

## Environment Notes

- macOS is the primary target (Apple Silicon and Intel)
- Some Linux support exists (Ubuntu, Alpine, Arch)
- Homebrew is used for package management on macOS
- Fish and Zsh are both configured
- Neovim is the primary editor

## Common Tasks

### Adding a new tool configuration

1. Create `dotfiles/<tool>/.<config-path>/`
2. Add config files
3. Add installation step to `bin/dotme-<tool>` if needed
4. Update `bin/dotme` to call the new script

### Adding a new bin script

1. Create file in `bin/`
2. Make it executable: `chmod +x bin/<script>`
3. Add help text and follow existing patterns

### Testing changes

```bash
# Test a specific component
dotme <component>

# Test scripts
cd test && pnpm test
```
