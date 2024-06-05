{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    input-fonts
  ];

  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../resources/alacritty.toml);
  };
}
