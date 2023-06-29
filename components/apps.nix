{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bookletimposer
    evolution
    gnome.gnome-calendar
    gnome.gnome-contacts
    inkscape
    obsidian
    spotify
    threema-desktop
    wireshark-qt
  ];
}
