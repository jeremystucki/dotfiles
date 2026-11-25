{ pkgs-unstable, ... }:
with pkgs-unstable.dotnetCorePackages;
{
  home.packages = [
    (combinePackages [
      sdk_10_0
    ])
  ];
}
