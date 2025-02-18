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
      imagemagick
      inkscape
      jetbrains.datagrip
      killall
      libreoffice
      mpv
      obsidian
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
      element-desktop
      colima
      docker
      iina
      iterm2
      xcodes
    ];
}
