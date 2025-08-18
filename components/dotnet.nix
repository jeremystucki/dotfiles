{pkgs, ...}:
with pkgs.dotnetCorePackages; {
  home.packages = [
    (combinePackages [
      sdk_8_0
      sdk_9_0
    ])
  ];
}
