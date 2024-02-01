{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    bookletimposer
    blanket
    pkgs-unstable.cartridges
    # citations
    evolution
    gnome-decoder
    gnome.gnome-calendar
    gnome.gnome-contacts
    gnome.gnome-characters
    imagemagick
    inkscape
    libreoffice
    obsidian
    pkgs-unstable.slack
    spotify
    threema-desktop
    wireshark-qt
    zathura
  ];
}
