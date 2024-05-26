{
  description = "My nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "github:bash/color-scheme-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      color-scheme-sync,
    }:
    let
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
        permittedInsecurePackages = [
          "electron-12.2.3"
          "electron-19.1.9"
          "electron-24.8.6"
          "electron-25.9.0"
        ];
      };
      pkgs = import nixpkgs {
        inherit system config;
        overlays = [
          (final: prev: { obsidian = prev.obsidian.override { electron = final.electron_24; }; })
        ];
      };
      pkgs-unstable = import nixpkgs-unstable { inherit system config; };
      homeManagerConfigForArch =
        { module }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./common/home-manager.nix
            module
          ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
            targets.genericLinux.enable = true;
          };
        };
      nixosConfig =
        { nixosModule, homeManagerModule ? {} }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs pkgs-unstable;
          };
          modules = [
            ./common/nixos.nix
            nixosModule
            color-scheme-sync.nixosModules.default
            home-manager.nixosModules.home-manager
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
      homeConfigurations."jeremy@volt" = homeManagerConfigForArch {
        module = ./volt/home-manager.nix;
      };
      nixosConfigurations."volt-nixos" = nixosConfig {
        nixosModule = ./volt/nixos-configuration.nix;
      };
      nixosConfigurations."zephyr-nixos" = nixosConfig {
        nixosModule = ./zephyr/nixos-configuration.nix;
      };
    };
}
