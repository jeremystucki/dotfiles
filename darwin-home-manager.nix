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
    xcodebuild
  ];

  home.homeDirectory = "/Users/jeremy";
}
