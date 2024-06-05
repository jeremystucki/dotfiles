{
  description = "My nix configuration";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "github:bash/color-scheme-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
      };
      pkgs = import inputs.nixpkgs { inherit system config; };
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system config; };
      nixosConfig =
        {
          nixosModule,
          homeManagerModule ? { },
        }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs pkgs-unstable;
          };
          modules = [
            ./common/nixos.nix
            nixosModule
            inputs.color-scheme-sync.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.users.jeremy.imports = [
                ./common/home-manager.nix
                ./common/nixos-home-manager.nix
                homeManagerModule
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                inherit pkgs-unstable;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations."volt-nixos" = nixosConfig {
        nixosModule = ./volt/nixos-configuration.nix;
        homeManagerModule = ./volt/home-manager.nix;
      };

      nixosConfigurations."zephyr-nixos" = nixosConfig {
        nixosModule = ./zephyr/nixos-configuration.nix;
      };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      formatter = pkgs-unstable.nixfmt-rfc-style;
    });
}
