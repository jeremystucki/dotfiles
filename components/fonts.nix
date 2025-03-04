{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    input-fonts
  ];
}
