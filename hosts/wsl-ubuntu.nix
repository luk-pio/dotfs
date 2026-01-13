{ config, pkgs, lib, ... }:

{
  home.username = "l";
  home.homeDirectory = "/home/l";

  # Enable generic Linux support
  targets.genericLinux.enable = true;

  # WSL-specific environment
  home.sessionVariables = {
    # WSL interop - use Windows browser
    BROWSER = "wslview";
  };

  # Additional packages for WSL
  home.packages = with pkgs; [
    wslu # WSL utilities (wslview, wslpath, etc.)
  ];
}
