{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    android-tools
    pkgs-unstable.android-studio
  ];
}
