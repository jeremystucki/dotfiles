{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bundler
    element-desktop
    iterm2
    kitty
    xcodes
  ];

  home.homeDirectory = "/Users/jeremy";
}
