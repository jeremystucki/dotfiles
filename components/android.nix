{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages =
    with pkgs;
    [ android-tools ] ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [ pkgs-unstable.android-studio ];
}
