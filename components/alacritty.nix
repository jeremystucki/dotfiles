{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    input-fonts
  ];

  home.file.".config/alacritty/alacritty.toml".source = ../resources/alacritty.toml;
}
