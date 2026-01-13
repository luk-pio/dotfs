{ config, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Don't manage plugins through Nix - use existing lazy.nvim setup
    # Just ensure Neovim and dependencies are available
  };

  # Link the external nvim config from flake input
  xdg.configFile."nvim".source = inputs.nvim-config;

  # Dependencies that Neovim plugins might need
  home.packages = with pkgs; [
    # Language servers
    lua-language-server
    nil # Nix LSP

    # Formatters and tools that plugins might expect
    stylua
    nodePackages.prettier
  ];
}
