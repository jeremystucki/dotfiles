{pkgs, ...}: {
  home.packages = [
    pkgs.gnomeExtensions.no-overview
  ];

  dconf = {
    enable = true;
    settings."org/gnome/shell".enabled-extensions = [
      pkgs.gnomeExtensions.gsconnect.extensionUuid
      pkgs.gnomeExtensions.no-overview.extensionUuid
    ];
  };
}
