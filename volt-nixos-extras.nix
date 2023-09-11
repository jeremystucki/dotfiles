{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    alacritty
    chromium
    firefox
    tailscale
    telegram-desktop
    xsel
    pkgs-unstable.android-studio
  ];
}
