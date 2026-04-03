{ config, pkgs, lib, ... }:

{
  # Ghostty configuration (macOS only via Homebrew cask)
  # This module just manages the config file
  config = lib.mkIf pkgs.stdenv.isDarwin {
    xdg.configFile."ghostty/config".text = ''
      font-family="Hack Nerd Font Mono"
      theme="Kanagawa Wave"
      macos-titlebar-style="hidden"
      font-thicken=true
    '';
  };
}
