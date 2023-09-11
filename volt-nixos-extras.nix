{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    firefox
    tailscale
    telegram-desktop
  ];
}
