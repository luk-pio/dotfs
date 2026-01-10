# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using GNU Stow for symlink management. Configuration files are organized in `files/` with a structure that mirrors the home directory.

## Key Commands

**Full installation (new machine):**
```bash
./install.sh
```

**Stow a single package (e.g., zsh configs):**
```bash
cd files && stow -v --adopt -t $HOME zsh
```

**Add Homebrew packages:**
Edit `Brewfile`, then run `brew bundle`

## Structure

- `files/` - Configuration packages, each directory is a stow package
  - `git/` - Git config (`.gitconfig`)
  - `zsh/` - Zsh config (`.zshrc`, `.config/zsh/`)
  - `tmux/` - Tmux config (`.tmux.conf`)
  - `nvim/` - Neovim (git submodule pointing to separate repo)
  - `ghostty/`, `iterm/`, `ideavim/`, `ssh/` - Other app configs
- `Brewfile` - Homebrew dependencies
- `install.sh` - One-shot setup script (Homebrew, stow, oh-my-zsh + plugins)

## Notes

- Neovim config is a git submodule at `files/nvim/.config/nvim` (separate repo: luk-pio/nvim)
- Zsh uses oh-my-zsh with plugins: zsh-syntax-highlighting, zsh-autosuggestions
- Files in `.gitignore` contain machine-specific configs (amzn/env.sh, ssh config)
- Stow `--adopt` flag pulls existing files into the repo, so be careful with new installs
