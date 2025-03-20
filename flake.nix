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
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "github:bash/color-scheme-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
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
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs:
    let
      config = {
        allowUnfree = true;
        input-fonts.acceptLicense = true;
      };
      nixSettings = {
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      hostConfigurations = {
        "volt-nixos" = {
          hostname = "volt-nixos";
          username = "jeremy";
        };
        "zephyr" = {
          hostname = "zephyr";
          username = "jeremy";
        };
        "work-macbook" = {
          username = "jeremy";
        };
      };
    in
    {
      nixosConfigurations =
        let
          system = "x86_64-linux";
          pkgs = import inputs.nixpkgs { inherit system config; };
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system config; };
          nixosConfig =
            {
              nixosModule,
              hostSpecificHomeManagerModule ? { },
              hostConfiguration,
            }:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit pkgs pkgs-unstable hostConfiguration; };
              modules = [
                ./common/nixos.nix
                nixSettings
                nixosModule
                inputs.color-scheme-sync.nixosModules.default
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.users.${hostConfiguration.username}.imports = [
                    ./common/home-manager.nix
                    ./components/alacritty.nix
                    ./components/apps.nix
                    ./components/haskell.nix
                    ./components/web.nix
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
            hostConfiguration = hostConfigurations.volt-nixos;
            hostSpecificHomeManagerModule = ./volt/home-manager.nix;
          };
          "zephyr" = nixosConfig {
            nixosModule = ./zephyr/nixos-configuration.nix;
            hostConfiguration = hostConfigurations.zephyr;
          };
        };

      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs = import inputs.nixpkgs { inherit system config; };
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system config; };
          hostConfiguration = hostConfigurations.work-macbook;
        in
        {
          "work-macbook" = inputs.darwin.lib.darwinSystem {
            inherit system;
            modules = [
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    git-format-staged = inputs.git-format-staged.packages.${system}.default;
                  })
                ];
              }
              nixSettings
              {
                nix.useDaemon = true;
                nix.settings.trusted-users = [ hostConfiguration.username ];

                system.stateVersion = 4;

                nixpkgs.config = config;
                environment.shells = [ pkgs.zsh ];
                programs.zsh.enable = true;
                users.users.${hostConfiguration.username}.home = "/Users/${hostConfiguration.username}";
                fonts.packages = [ pkgs.jetbrains-mono ];

                homebrew = {
                  enable = true;
                  casks = [ "ghostty" ];
                };
              }
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${hostConfiguration.username}.imports = [
                    ./common/home-manager.nix
                    ./components/apps.nix
                  ];
                  extraSpecialArgs = { inherit pkgs-unstable hostConfiguration; };
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
