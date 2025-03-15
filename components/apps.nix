{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [
      nvd
      obsidian
      protonmail-desktop
      signal-desktop
      pkgs-unstable.discord
      pkgs-unstable.spotify
    ] ++ lib.optionals (!stdenv.isDarwin) [
      bambu-studio
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
