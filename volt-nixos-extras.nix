{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    alacritty
    firefox
    tailscale
    telegram-desktop
    pkgs-unstable.android-studio
  ];
}
