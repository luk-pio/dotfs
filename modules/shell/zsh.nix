{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    # Enable built-in features (replaces oh-my-zsh plugins)
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    # History configuration
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      share = true;
      extended = true;
    };

    # Vi mode (replaces vi-mode plugin)
    defaultKeymap = "viins";

    # Shell aliases (from alias.sh)
    shellAliases = {
      vim = "nvim";
      v = "nvim";
      cat = "bat";
      s = "sesh connect $(sesh list | fzf)";
      ops = "eval $(op signin my)";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
    };

    # Init extra (for functions and complex setup)
    initExtra = ''
      # Yazi wrapper function (from alias.sh)
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # mkd function - make directory and cd into it
      function mkd() {
        mkdir -p "$@" && cd "$_";
      }

      # cfg function - edit zsh config files
      function cfg() {
        $EDITOR "$HOME/.config/zsh/$@.sh"
      }

      # Claude Code in new git worktree
      function ccwt() {
        git worktree add -b "$1" "../$1" "''${2:-HEAD}" && cd "../$1" && claude
      }

      # Completion settings (from autocomplete.sh)
      zstyle ':completion:*' menu select
      _comp_options+=(globdots)

      # Source machine-specific secrets if they exist
      [ -f ~/.config/zsh/secrets.sh ] && source ~/.config/zsh/secrets.sh

      # NVM setup (if needed)
      export NVM_DIR="$HOME/.config/nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      # Bun setup (if installed)
      if [ -d "$HOME/.bun" ]; then
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
        [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
      fi
    '';

    # Environment variables
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
    };
  };
}
