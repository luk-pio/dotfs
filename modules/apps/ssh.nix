{ config, pkgs, lib, ... }:

{
  # SSH configuration varies by platform due to 1Password agent path
  programs.ssh = {
    enable = true;

    # Common SSH settings
    extraConfig = lib.mkMerge [
      # macOS 1Password agent
      (lib.mkIf pkgs.stdenv.isDarwin ''
        Host *
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '')
      # Linux 1Password agent (if using 1Password on Linux)
      (lib.mkIf pkgs.stdenv.isLinux ''
        Host *
          IdentityAgent "~/.1password/agent.sock"
      '')
    ];
  };
}
