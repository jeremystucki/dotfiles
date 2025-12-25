{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      obsidian
      pkgs-unstable.discord
      pkgs-unstable.signal-desktop-bin
      # pkgs-unstable.spotify
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
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
      killall
      libreoffice
      mpv
      pdfarranger
      piper
      protonmail-desktop
      telegram-desktop
      threema-desktop
      wireshark-qt
      wl-clipboard
      xsel
      zathura
    ]
    ++ lib.optionals stdenv.isDarwin [
      colima
      docker
      google-chrome
      iina
      iterm2
      numi
      rectangle
      swiftlint
      xcodes
      pkgs-unstable.element-desktop
    ];
}
