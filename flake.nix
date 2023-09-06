{
  description = "Home Manager configuration of jeremy";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          input-fonts.acceptLicense = true;
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
      };
    in {
      homeConfigurations."jeremy@volt" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./volt.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };       
      };
      homeConfigurations."jeremy@zephyr" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./zephyr.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };       
      };
    };
}
