{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;

    # Let TPM and existing config handle most settings
    # We just ensure tmux is available and link the config
  };

  # Link existing tmux configuration
  # TPM will handle plugin management
  xdg.configFile."tmux/tmux.conf".source = ../config/tmux/tmux.conf;
  home.file.".tmux.conf".text = ''
    # Source the main config from XDG location
    source-file ~/.config/tmux/tmux.conf
  '';

  # Ensure TPM is available
  home.file.".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "v3.1.0";
    sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
  };
}
