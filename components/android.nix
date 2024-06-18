{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [ android-tools ] ++ lib.optional (!stdenv.isDarwin) [ pkgs-unstable.android-studio ];
}
