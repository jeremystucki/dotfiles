{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bundler
    element-desktop
    colima
    docker
    iterm2
    kitty
    xcodes
  ];

  home.homeDirectory = "/Users/jeremy";
}
