{ pkgs, ... }:

{
  imports = map (x: ../components + x) [
    /common-apps.nix
    /haskell.nix
    /web.nix
  ];

  home.homeDirectory = "/home/jeremy";
}
