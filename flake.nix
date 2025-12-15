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
      url = "github:nixos/nixpkgs/nixos-25.11";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    color-scheme-sync = {
      url = "github:bash/color-scheme-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
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

  outputs = inputs: let
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    };
    username = "jeremy";
  in
    {
      nixosConfigurations = let
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs {
          inherit system config;
        };
        pkgs-unstable = import inputs.nixpkgs-unstable {
          inherit system config;
        };
        nixosConfig = {
          nixosModule,
          hostSpecificHomeManagerModule ? {},
          hostname,
        }: let
          hostConfiguration = {inherit username hostname;};
        in
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit pkgs-unstable hostConfiguration;};
            modules = [
              {nixpkgs.pkgs = pkgs;}
              ./common/nixos.nix
              ./common/desktop-gnome.nix
              ./common/1password.nix
              ./common/nix-settings.nix
              nixosModule
              inputs.color-scheme-sync.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.users.${username}.imports = [
                  ./common/home-manager.nix
                  ./common/apps.nix
                  ./components/alacritty.nix
                  ./components/haskell.nix
                  ./components/web.nix
                  hostSpecificHomeManagerModule
                ];
                home-manager.useGlobalPkgs = true;
                home-manager.extraSpecialArgs = {inherit pkgs-unstable hostConfiguration;};
              }
            ];
          };
      in {
        "volt-nixos" = nixosConfig {
          nixosModule = ./volt/nixos-configuration.nix;
          hostname = "volt-nixos";
          hostSpecificHomeManagerModule = ./volt/home-manager.nix;
        };
        "zephyr" = nixosConfig {
          nixosModule = ./zephyr/nixos-configuration.nix;
          hostname = "zephyr";
        };
      };

      darwinConfigurations = let
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs {inherit system config;};
        pkgs-unstable = import inputs.nixpkgs-unstable {inherit system config;};
        hostConfiguration = {inherit username;};
        git-format-staged = inputs.git-format-staged.packages.${system}.default;
      in {
        "work-macbook" = inputs.darwin.lib.darwinSystem {
          inherit system;
          modules = [
            {
              nixpkgs.config = config;
            }
            ./common/nix-settings.nix
            ./darwin-configuration.nix
            inputs.home-manager.darwinModules.home-manager
          ];
          specialArgs = {inherit inputs hostConfiguration pkgs-unstable git-format-staged;};
        };
      };

      homeConfigurations."stefis-macbook" = let
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs {inherit system config;};
        pkgs-unstable = import inputs.nixpkgs-unstable {inherit system config;};
        hostConfiguration = {inherit username;};
        git-format-staged = inputs.git-format-staged.packages.${system}.default;
      in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./common/home-manager.nix
            ./components/dotnet.nix
          ];

          extraSpecialArgs = {inherit hostConfiguration pkgs-unstable git-format-staged;};
        };
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
    });
}
