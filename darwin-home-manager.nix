{ pkgs, ... }:

{
  home.packages = with pkgs; [
    element-desktop
    colima
    docker
    iterm2
    kitty
    xcodes
    ruby
  ];

  home.homeDirectory = "/Users/jeremy";
}
