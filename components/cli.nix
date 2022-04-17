{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    fd
    ripgrep
    tealdeer
  ];

  programs.bat.enable = true;
  programs.zsh.shellAliases.cat = "bat";
}
