{ config, pkgs, lib, ... }:

{
  # Nix-darwin system configuration
  system.stateVersion = 4;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix-command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Homebrew integration for GUI apps and packages not in nixpkgs
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "joshmedeski/sesh"
    ];
    brews = [
      "sesh" # Not in nixpkgs
    ];
    casks = [
      "ghostty"
      "obsidian"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # System defaults (optional macOS settings)
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Enable Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Home-manager user config
  home-manager.users.l = {
    home.homeDirectory = "/Users/l";
    home.username = "l";
  };

  # System programs
  programs.zsh.enable = true;
}
