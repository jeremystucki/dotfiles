{
  description = "Home Manager configuration of jeremy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "github:bash/color-scheme-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, color-scheme-sync }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          input-fonts.acceptLicense = true;
          permittedInsecurePackages = [
            "electron-12.2.3"
            "electron-24.8.6"
          ];
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in {
      homeConfigurations."jeremy@volt" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./volt/common-home-manager.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          targets.genericLinux.enable = true;
        };       
      };
      homeConfigurations."jeremy@zephyr" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./zephyr/home-manager.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };       
      };
      nixosConfigurations."volt-nixos" = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./volt/nixos-configuration.nix
          color-scheme-sync.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.users.jeremy = import ./volt/nixos-home-manager.nix { inherit pkgs; };
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = {
              inherit pkgs-unstable;
            };       
          }
        ];
      };
    };
}
