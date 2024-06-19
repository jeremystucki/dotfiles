{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [ android-tools ] ++ lib.optionals (!stdenv.isDarwin) [ pkgs-unstable.android-studio ];
}
