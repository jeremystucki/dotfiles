{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    asciinema
    bat
    delta
    dogdns
    du-dust
    entr
    fd
    ffmpeg-full
    miller
    ngrok
    nmap
    pdftk
    ranger
    ripgrep
    tealdeer
    tokei
    wol
    youtube-dl
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

  programs.bottom = {
    enable = true;
    settings.flags.color = "nord";
  };
}
