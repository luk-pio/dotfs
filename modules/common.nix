{ config, pkgs, lib, ... }:

{
  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Basic home configuration
  home.stateVersion = "24.05";

  # XDG directories
  xdg.enable = true;

  # Common packages across all platforms
  home.packages = with pkgs; [
    # CLI tools from Brewfile
    fzf
    ripgrep
    bat
    zoxide
    yazi
    jq
    delta # git-delta
    gnused # gnu-sed
    nmap
    inetutils # telnet

    # Additional utilities
    fd
    eza
    htop
    tree
  ];

  # Session variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    FILE = "yazi";
  };

  # Session path additions
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # FZF configuration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --hidden -l \"\"";
    defaultOptions = [
      "--height 40%"
      "--reverse"
    ];
  };

  # Zoxide configuration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Bat configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  # Yazi file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
