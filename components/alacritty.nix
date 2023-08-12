{ pkgs, ... }:

{
  home.packages = [ pkgs.nerdfonts pkgs.input-fonts ];
  home.file.".config/alacritty/alacritty.yml".source = ../resources/alacritty.yml;
}
