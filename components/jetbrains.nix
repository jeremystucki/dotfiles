{ pkgs, ... }:

{
  home.packages = with pkgs.jetbrains; [
    clion
    idea-ultimate
    rider
    webstorm
  ];
}
