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
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      # This does not work due to broken packages
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    {
      nixosConfigurations =
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
          "volt-nixos" = nixosConfig {
            nixosModule = ./volt/nixos-configuration.nix;
            homeManagerModule = ./volt/home-manager.nix;
          };

          "zephyr-nixos" = nixosConfig {
            nixosModule = ./zephyr/nixos-configuration.nix;
          };
        };

      darwinConfigurations =
        let
          system = "x86_64-darwin";
          config = {
            allowUnfree = true;
            input-fonts.acceptLicense = true;
          };
          pkgs = import inputs.nixpkgs { inherit system config; };
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system config; };
        in
        {
          "work-macbook" = inputs.darwin.lib.darwinSystem {
            inherit system;

            modules = [
              {
                nix.useDaemon = true;
                nix.settings = {
                  trusted-users = [ "jeremy" ];
                  experimental-features = [
                    "nix-command"
                    "flakes"
                  ];
                };

                nixpkgs.config = config;
                environment.shells = [ pkgs.zsh ];
                programs.zsh.enable = true;
                users.users.jeremy.home = "/Users/jeremy";
                fonts.fonts = [ pkgs.jetbrains-mono ];
              }
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.jeremy.imports = [
                    ./common/home-manager.nix
                    ./darwin-home-manager.nix
                  ];
                  extraSpecialArgs = {
                    inherit pkgs-unstable;
                  };
                  sharedModules = [ inputs.mac-app-util.homeManagerModules.default ];
                };
              }
            ];
          };
        };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      formatter = inputs.nixpkgs-unstable.legacyPackages.${system}.nixfmt-rfc-style;
    });
}
