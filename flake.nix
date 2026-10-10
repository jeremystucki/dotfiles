{
  description = "My nix configuration";

  inputs = {
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nixos-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "git+https://codeberg.org/tautropfli/color-scheme-sync.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.systems.follows = "systems";
      # This does not work due to broken packages
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    git-format-staged = {
      url = "github:hallettj/git-format-staged";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
      };
      username = "jeremy";
    in
    {
      nixosConfigurations =
        let
          system = "x86_64-linux";
          pkgs-stable = import inputs.nixpkgs { inherit system config; };
          pkgs-unstable = import inputs.nixos-unstable { inherit system config; };
          nixosConfig =
            {
              nixosModule,
              hostSpecificHomeManagerModule ? { },
              hostname,
              unstable ? false,
            }:
            let
              hostConfiguration = {
                inherit username hostname;
              };
              nixpkgs = if unstable then inputs.nixos-unstable else inputs.nixpkgs;
              home-manager = if unstable then inputs.home-manager-unstable else inputs.home-manager;
              pkgs = if unstable then pkgs-unstable else pkgs-stable;
            in
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit pkgs-unstable hostConfiguration; };
              modules = [
                { nixpkgs.pkgs = pkgs; }
                ./common/fonts.nix
                ./common/nixos.nix
                ./common/desktop-gnome.nix
                ./common/1password.nix
                ./common/nix-settings.nix
                nixosModule
                inputs.color-scheme-sync.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                  home-manager.users.${hostConfiguration.username}.imports = [
                    ./common/home-manager.nix
                    ./common/gnome-extensions.nix
                    hostSpecificHomeManagerModule
                  ];
                  home-manager.useGlobalPkgs = true;
                  home-manager.extraSpecialArgs = { inherit pkgs-unstable hostConfiguration; };
                }
              ];
            };
        in
        {
          "volt-nixos" = nixosConfig {
            nixosModule = ./volt/nixos-configuration.nix;
            hostname = "volt-nixos";
          };
          "zephyr" = nixosConfig {
            nixosModule = ./zephyr/nixos-configuration.nix;
            hostname = "zephyr";
          };
          "niffty" = nixosConfig {
            nixosModule = ./niffty/nixos-configuration.nix;
            hostSpecificHomeManagerModule = ./niffty/home-manager.nix;
            hostname = "niffty";
            unstable = true;
          };
        };

      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system config; };
          git-format-staged = inputs.git-format-staged.packages.${system}.default;
          darwinConfig =
            _:
            let
              hostConfiguration = {
                inherit username;
              };
            in
            inputs.darwin.lib.darwinSystem {
              inherit system;
              modules = [
                {
                  nixpkgs.config = config;
                }
                ./common/fonts.nix
                ./common/nix-settings.nix
                ./common/darwin.nix
                inputs.home-manager.darwinModules.home-manager
              ];
              specialArgs = {
                inherit
                  inputs
                  hostConfiguration
                  pkgs-unstable
                  git-format-staged
                  ;
              };
            };
        in
        {
          "macbook" = darwinConfig {
          };
          "work-macbook" = darwinConfig {
          };
        };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      formatter = inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree;
    });
}
