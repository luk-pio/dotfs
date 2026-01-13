{
  description = "luk-pio's dotfiles managed with Nix and home-manager";

  inputs = {
    # Core inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS support
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim config as external input (not a flake, just fetch the repo)
    nvim-config = {
      url = "github:luk-pio/nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, nvim-config, ... }@inputs:
    let
      # Supported systems
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];

      # Helper to generate per-system outputs
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Common home-manager modules
      commonModules = [
        ./modules/common.nix
        ./modules/shell/zsh.nix
        ./modules/shell/starship.nix
        ./modules/git.nix
        ./modules/tmux.nix
        ./modules/neovim.nix
        ./modules/apps/ideavim.nix
        ./modules/apps/claude.nix
      ];
    in
    {
      # macOS configuration using nix-darwin
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.l = { imports = commonModules ++ [
              ./modules/apps/ghostty.nix
              ./modules/apps/ssh.nix
              ./modules/apps/iterm.nix
            ]; };
          }
        ];
      };

      # Standalone home-manager for WSL Ubuntu
      homeConfigurations."l@wsl-ubuntu" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/wsl-ubuntu.nix
          ./modules/apps/ssh.nix
        ];
      };

      # Standalone home-manager for Amazon Linux 2
      homeConfigurations."l@amzn-linux2" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = commonModules ++ [
          ./hosts/amzn-linux2.nix
          ./modules/apps/ssh.nix
        ];
      };

      # Development shell for this repo
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          packages = with nixpkgs.legacyPackages.${system}; [
            nixpkgs-fmt
            nil # Nix LSP
          ];
        };
      });
    };
}
