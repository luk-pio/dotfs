# dotfs

My dotfiles. There are many like them but these ones are mine.

## Overview

A cross-platform (macOS/Linux) dotfiles setup using [GNU Stow](https://www.gnu.org/software/stow/) for symlink management. Optimized for a terminal-centric workflow with fuzzy-finding, Vim keybindings, and modern CLI tools.

## What's Included

| Directory | Configuration |
|-----------|---------------|
| `git/` | Git config with LFS, aliases (including `fza` for fuzzy add) |
| `zsh/` | Zsh with Oh-My-Zsh, syntax highlighting, autosuggestions, vi-mode |
| `tmux/` | Tmux with Vim keys, sesh integration, Kanagawa theme |
| `nvim/` | Neovim config (git submodule → [luk-pio/nvim](https://github.com/luk-pio/nvim)) |
| `ghostty/` | Ghostty terminal (Hack Nerd Font, Kanagawa theme) |
| `iterm/` | iTerm2 color scheme (Kanagawa) |
| `ideavim/` | IdeaVim config for JetBrains IDEs |
| `ssh/` | SSH config (gitignored) |

### Key Tools Configured

- **fzf** - Fuzzy finder integrated throughout (git, tmux, history)
- **zoxide** - Smart directory jumping (`z` command)
- **bat** - Syntax-highlighted `cat` replacement
- **ripgrep** - Fast file content search
- **yazi** - Modern file manager
- **sesh** - Tmux session manager with fzf

## Installation

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/luk-pio/dotfs.git
cd dotfs

# Run install script
./install.sh
```

The install script will:
1. Install Homebrew (if not present)
2. Install packages from `Brewfile`
3. Symlink configs to `$HOME` via Stow
4. Set up Oh-My-Zsh with plugins

### Manual Stow Usage

To symlink individual configs:
```bash
cd files
stow -v -t $HOME zsh      # Just zsh
stow -v -t $HOME tmux git # Multiple at once
```

## Directory Structure

```
dotfs/
├── files/           # Stow packages (each dir = one package)
│   ├── git/         # → ~/.gitconfig
│   ├── zsh/         # → ~/.zshrc, ~/.config/zsh/
│   ├── tmux/        # → ~/.tmux.conf
│   ├── nvim/        # → ~/.config/nvim/ (submodule)
│   ├── ghostty/     # → ~/.config/ghostty/
│   ├── iterm/       # → ~/.iterm/
│   ├── ideavim/     # → ~/.ideavimrc
│   └── ssh/         # → ~/.ssh/config
├── install.sh       # Setup script
└── Brewfile         # Homebrew packages
```

## Notable Keybindings

### Tmux (prefix: `Ctrl-Space`)
- `Alt-p` - Session picker (sesh + fzf)

### Zsh
- Vi-mode enabled
- `Ctrl-r` - Fuzzy history search

### Aliases
- `v` / `vim` → neovim
- `cat` → bat
- `s` → sesh session picker
- `y` → yazi with directory switching
