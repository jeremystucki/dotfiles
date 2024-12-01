{ pkgs-unstable, ... }:

with pkgs-unstable;
with dotnetCorePackages;
{
  home.packages = [
    (combinePackages [
      sdk_8_0
    ])
  ] ++ lib.optionals (!stdenv.isDarwin) [ jetbrains.rider ];
}
