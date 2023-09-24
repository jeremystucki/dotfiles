{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-tools
    asciinema
    bat
    caddy
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
    postgresql
    ranger
    ripgrep
    tokei
    units
    wol
    yt-dlp
    zip
    nodePackages.svgo
  ];

  programs.bat.enable = true;
  programs.jq.enable = true;
  programs.lsd.enable = true;
  programs.pandoc.enable = true;
  programs.zoxide.enable = true;

  programs.zsh.shellAliases = {
    cat = "bat";
    ls = "lsd -l";
    lt = "lsd --tree";
  };

  programs.bottom = {
    enable = true;
    settings.flags.color = "nord";
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      updates.auto_update = true;
    };
  };
}
