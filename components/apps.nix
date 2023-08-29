{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bookletimposer
    blanket
    citations
    evolution
    gnome-decoder
    gnome.gnome-calendar
    gnome.gnome-contacts
    gnome.gnome-characters
    inkscape
    obsidian
    spotify
    threema-desktop
    wireshark-qt
  ];
}
