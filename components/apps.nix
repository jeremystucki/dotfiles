{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
