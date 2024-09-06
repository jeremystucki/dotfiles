{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    bambu-studio
    blanket
    evolution
    gnome-decoder
    gnome.gnome-calendar
    gnome.gnome-characters
    gnome.gnome-contacts
    handbrake
    imagemagick
    inkscape
    libreoffice
    mpv
    obsidian
    piper
    cartridges
    pkgs-unstable.slack
    threema-desktop
    wireshark-qt
    zathura
  ];
}
