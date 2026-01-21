{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  isLinux = !pkgs.stdenv.isDarwin;
in {
  programs.chromium.enable = isLinux;
  programs.firefox.enable = isLinux;
  programs.mpv.enable = isLinux;
  programs.zathura.enable = isLinux;

  home.packages = with pkgs;
    [
      obsidian
      pkgs-unstable.discord
      pkgs-unstable.signal-desktop-bin
    ]
    ++ lib.optionals isLinux [
      blanket
      cartridges
      ddcutil
      evolution
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
      pdfarranger
      piper
      protonmail-desktop
      spotify
      telegram-desktop
      threema-desktop
      wireshark-qt
      wl-clipboard
      xsel
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
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
