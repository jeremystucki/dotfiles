{
  description = "Home Manager configuration of jeremy";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          input-fonts.acceptLicense = true; # TODO: Move out of here
        };
      };
    in {
      homeConfigurations."jeremy@volt" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./volt.nix ];
      };
      homeConfigurations."jeremy@zephyr" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./zephyr.nix ];
      };
    };
}
