{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ../resources/alacritty.toml);
  };
}
