{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [
      bambu-studio
      blanket
      evolution
      gnome-decoder
      gnome-calendar
      gnome-characters
      gnome-contacts
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
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      pdfarranger
    ];
}
