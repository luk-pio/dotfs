# dotfs

My dotfiles. There are many like them but these ones are mine.

## Overview

A cross-platform (macOS/Linux) dotfiles setup with two installation methods:

1. **Nix Flakes + home-manager** (recommended) - Declarative, reproducible, single command setup
2. **GNU Stow + Homebrew** (legacy) - Traditional symlink-based approach

Optimized for a terminal-centric workflow with fuzzy-finding, Vim keybindings, and modern CLI tools.

## What's Included

| Component | Configuration |
|-----------|---------------|
| **Shell** | Zsh with starship prompt, autosuggestions, syntax highlighting, vi-mode |
| **Git** | Git config with delta diffs, LFS, fuzzy add alias |
| **Tmux** | Vim keys, sesh integration, Kanagawa theme |
| **Neovim** | Full config with LSP, Telescope, Treesitter ([luk-pio/nvim](https://github.com/luk-pio/nvim)) |
| **Terminal** | Ghostty (macOS), iTerm2 color scheme |
| **IDE** | IdeaVim config for JetBrains IDEs |
| **Claude** | Claude Code settings and custom commands |

### Key Tools

- **fzf** - Fuzzy finder integrated throughout (git, tmux, history)
- **zoxide** - Smart directory jumping (`z` command)
- **bat** - Syntax-highlighted `cat` replacement
- **ripgrep** - Fast file content search
- **yazi** - Modern terminal file manager
- **sesh** - Tmux session manager with fzf
- **delta** - Syntax-highlighted git diffs

---

## Installation (Nix Flakes)

The Nix setup provides declarative, reproducible configuration across all platforms.

### Supported Platforms

| Platform | Configuration | Command |
|----------|---------------|---------|
| macOS (Apple Silicon) | `darwinConfigurations."macbook"` | `darwin-rebuild switch --flake .` |
| Ubuntu on WSL | `homeConfigurations."l@wsl-ubuntu"` | `home-manager switch --flake .#l@wsl-ubuntu` |
| Amazon Linux 2 | `homeConfigurations."l@amzn-linux2"` | `home-manager switch --flake .#l@amzn-linux2` |

### Prerequisites

#### 1. Install Nix

```bash
# Multi-user installation (recommended)
sh <(curl -L https://nixos.org/nix/install) --daemon
```

After installation, restart your terminal or run:
```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

#### 2. Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

If using the Nix daemon, restart it:
```bash
# macOS
sudo launchctl kickstart -k system/org.nixos.nix-daemon

# Linux
sudo systemctl restart nix-daemon
```

### Quick Start

```bash
# Clone the repo
git clone https://github.com/luk-pio/dotfs.git
cd dotfs

# Validate the flake
nix flake check

# Apply configuration (see platform-specific commands below)
```

### macOS Setup

Uses nix-darwin for system-level configuration + home-manager for dotfiles.

```bash
# First time setup (bootstraps nix-darwin)
nix run nix-darwin -- switch --flake .

# Subsequent updates
darwin-rebuild switch --flake .
```

This will:
- Install all CLI packages via Nix
- Install GUI apps via Homebrew (ghostty, obsidian)
- Install sesh via Homebrew (not in nixpkgs)
- Configure system defaults (dock, finder, keyboard)
- Install Hack Nerd Font
- Enable Touch ID for sudo
- Set up all dotfiles

### Linux Setup (WSL / Amazon Linux 2)

Uses standalone home-manager for dotfiles only.

```bash
# WSL Ubuntu
nix run home-manager -- switch --flake .#l@wsl-ubuntu

# Amazon Linux 2
nix run home-manager -- switch --flake .#l@amzn-linux2

# Subsequent updates (after first run)
home-manager switch --flake .#l@wsl-ubuntu
```

### Machine-Specific Secrets

Create a secrets file for environment variables that shouldn't be in git:

```bash
mkdir -p ~/.config/zsh
cat > ~/.config/zsh/secrets.sh << 'EOF'
# Machine-specific environment variables
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export SOME_API_TOKEN="..."
EOF
chmod 600 ~/.config/zsh/secrets.sh
```

This file is automatically sourced by the Nix-managed zsh config.

### Common Operations

```bash
# Update all flake inputs (nixpkgs, home-manager, etc.)
nix flake update

# Update just your neovim config
nix flake lock --update-input nvim-config

# View available generations
home-manager generations

# Rollback to previous generation
home-manager switch --rollback

# Garbage collect old generations (free disk space)
nix-collect-garbage -d

# Enter dev shell with Nix tooling (formatter, LSP)
nix develop
```

### Customization

#### Adding Packages

Edit `modules/common.nix`:
```nix
home.packages = with pkgs; [
  # Add packages here
  your-package
];
```

#### Platform-Specific Packages

Edit the relevant host file (`hosts/darwin.nix`, `hosts/wsl-ubuntu.nix`, etc.):
```nix
home.packages = with pkgs; [
  # Platform-specific packages
];
```

#### Adding macOS GUI Apps

Edit `hosts/darwin.nix`:
```nix
homebrew.casks = [
  "your-app"
];
```

### Nix Directory Structure

```
dotfs/
├── flake.nix              # Main entry point, defines all configurations
├── flake.lock             # Locked dependency versions
├── hosts/                 # Platform-specific configurations
│   ├── darwin.nix         # macOS (nix-darwin + home-manager)
│   ├── wsl-ubuntu.nix     # WSL Ubuntu (home-manager)
│   └── amzn-linux2.nix    # Amazon Linux 2 (home-manager)
├── modules/               # Reusable home-manager modules
│   ├── common.nix         # Shared packages & settings
│   ├── git.nix            # Git configuration
│   ├── tmux.nix           # Tmux + TPM
│   ├── neovim.nix         # Neovim (external repo)
│   ├── shell/
│   │   ├── zsh.nix        # Zsh configuration
│   │   └── starship.nix   # Starship prompt
│   └── apps/
│       ├── ghostty.nix    # Ghostty (macOS)
│       ├── ideavim.nix    # IdeaVim
│       ├── claude.nix     # Claude Code
│       ├── ssh.nix        # SSH with 1Password
│       └── iterm.nix      # iTerm colors (macOS)
├── config/                # Raw config files
│   ├── tmux/              # Tmux config (used by TPM)
│   ├── claude/            # Claude commands
│   └── iterm/             # iTerm color scheme
└── secrets/               # Machine-specific (gitignored)
```

### Troubleshooting

**"experimental feature 'flakes' is disabled"**
```bash
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
# Restart nix-daemon if needed
```

**"error: cannot find flake 'flake:home-manager'"**
```bash
# Use the full nix run command instead
nix run github:nix-community/home-manager -- switch --flake .#l@wsl-ubuntu
```

**"hash mismatch" errors**
```bash
# Update the flake lock
nix flake update
```

**TPM plugins not loading**
```bash
# Manually install TPM plugins
~/.tmux/plugins/tpm/bin/install_plugins
```

---

## Installation (Legacy: GNU Stow)

The traditional stow-based setup remains available in the `files/` directory.

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

```bash
cd files
stow -v -t $HOME zsh      # Just zsh
stow -v -t $HOME tmux git # Multiple at once
```

---

## Keybindings

### Tmux (prefix: `Ctrl-Space`)

| Action | Keybinding |
|--------|------------|
| **Sessions** | |
| Session picker (sesh + fzf) | `Alt-p` |
| **Pane Splitting** | |
| Split vertically (left/right) | `prefix + v` |
| Split horizontally (top/bottom) | `prefix + s` |
| **Pane Navigation** | |
| Move left/down/up/right | `prefix + h/j/k/l` |
| **Pane Resizing** | |
| Resize left/down/up/right | `prefix + H/J/K/L` (repeatable) |
| **Pane Management** | |
| Swap with previous | `prefix + <` |
| Swap with next | `prefix + >` |
| Zoom/unzoom | `prefix + z` |
| Kill pane | `prefix + x` |
| **Windows** | |
| New window | `prefix + c` |
| Next/previous window | `prefix + n/p` |

### Zsh

| Action | Keybinding |
|--------|------------|
| Vi-mode | Enabled by default |
| Fuzzy history search | `Ctrl-r` |
| Edit command in $EDITOR | `v` (in normal mode) |

### Shell Aliases

| Alias | Command |
|-------|---------|
| `v` / `vim` | neovim |
| `cat` | bat (syntax highlighted) |
| `s` | sesh session picker |
| `y` | yazi with directory switching |
| `z <dir>` | zoxide smart jump |
| `mkd <dir>` | mkdir + cd |
| `ccwt <branch>` | Create git worktree + open Claude |

---

## License

MIT
