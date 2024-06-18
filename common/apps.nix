{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.obsidian
    pkgs-unstable.discord
    pkgs-unstable.spotify
  ];
}
