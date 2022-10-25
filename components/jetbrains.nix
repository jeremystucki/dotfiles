{ pkgs, ... }:

{
  home.packages = with pkgs.jetbrains; [
    clion
    datagrip
    idea-ultimate
    webstorm
  ];
}
