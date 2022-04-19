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

  programs.jq.enable = true;
  programs.pandoc.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
}
