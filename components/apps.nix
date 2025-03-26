{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [
      obsidian
      protonmail-desktop
      pkgs-unstable.discord
      pkgs-unstable.signal-desktop
      pkgs-unstable.spotify
    ] ++ lib.optionals (!stdenv.isDarwin) [
      blanket
      cartridges
      chromium
      ddcutil
      evolution
      firefox
      foot
      gnome-calendar
      gnome-characters
      gnome-contacts
      gnome-decoder
      gnome-tweaks
      handbrake
      hydrapaper
      imagemagick
      inkscape
      jetbrains.datagrip
      killall
      libreoffice
      mpv
      pdfarranger
      piper
      telegram-desktop
      threema-desktop
      wireshark-qt
      wl-clipboard
      xsel
      zathura
      pkgs-unstable.discord
      pkgs-unstable.orca-slicer
    ] ++ lib.optionals (stdenv.isDarwin) [
      colima
      docker
      element-desktop
      google-chrome
      iina
      iterm2
      rectangle
      xcodes
    ];
}
