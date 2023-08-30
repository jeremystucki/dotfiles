{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerdfonts
    input-fonts
  ];

  home.file.".config/alacritty/alacritty.yml".source = ../resources/alacritty.yml;
}
