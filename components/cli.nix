{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    fd
    jq
    pandoc
    ripgrep
    tealdeer
  ];

  programs.bat.enable = true;
  programs.zsh.shellAliases.cat = "bat";
}
