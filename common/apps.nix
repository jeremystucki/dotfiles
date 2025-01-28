{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.obsidian
    pkgs.protonmail-desktop
    pkgs-unstable.discord
    pkgs-unstable.spotify
  ];
}
