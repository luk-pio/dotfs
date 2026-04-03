{ config, pkgs, lib, ... }:

{
  # iTerm2 color scheme (macOS only)
  config = lib.mkIf pkgs.stdenv.isDarwin {
    home.file.".iterm/kanagawa.itermcolors".source = ../../config/iterm/kanagawa.itermcolors;
  };
}
