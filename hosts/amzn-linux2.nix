{ config, pkgs, lib, ... }:

{
  home.username = "l";
  home.homeDirectory = "/home/l";

  # Enable generic Linux support
  targets.genericLinux.enable = true;

  # Amazon Linux 2 considerations:
  # - Older glibc (2.26) - some newer packages may have compatibility issues
  # - Use stable nixpkgs for better compatibility if needed
  # - Some packages may need to be excluded or use static builds

  # Machine-specific secrets sourced from zsh initExtra
  # Create ~/.config/zsh/secrets.sh manually on this machine
}
