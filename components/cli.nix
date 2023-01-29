{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    dogdns
    fd
    ffmpeg-full
    ripgrep
    tealdeer
    zip
    nodePackages.svgo
  ];

  programs.bat.enable = true;
  programs.zsh.shellAliases.cat = "bat";

  programs.jq.enable = true;
  programs.pandoc.enable = true;

  programs.lsd.enable = true;
  programs.zsh.shellAliases.ls = "lsd -l";
  programs.zsh.shellAliases.lt = "lsd --tree";

  programs.zoxide.enable = true;

  programs.tmux = {
    enable = true;
    keyMode = "vi";
  };
}
