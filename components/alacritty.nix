{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    input-fonts
  ];

  home.file.".config/alacritty/alacritty.yml".source = ../resources/alacritty.yml;
}
