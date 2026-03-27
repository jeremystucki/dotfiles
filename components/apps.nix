{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  isLinux = !pkgs.stdenv.isDarwin;
in {
  programs.chromium.enable = isLinux;
  programs.mpv.enable = isLinux;
  programs.zathura.enable = isLinux;

  programs.firefox = {
    enable = isLinux;
    package = pkgs-unstable.firefox;
  };

  home.packages = with pkgs;
    [
      obsidian
      pkgs-unstable.discord
      pkgs-unstable.signal-desktop
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
      qdiskinfo
      spotify
      telegram-desktop
      threema-desktop
      wireshark-qt
      wl-clipboard
      xsel
      pkgs-unstable.rpi-imager
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      pkgs-unstable.colima
      docker
      # google-chrome
      iina
      iterm2
      numi
      rectangle
      swiftlint
      xcodes
      # pkgs-unstable.element-desktop
    ];
}
