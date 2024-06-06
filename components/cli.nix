{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    asciinema
    bat
    caddy
    delta
    dogdns
    du-dust
    entr
    fd
    ffmpeg-full
    file
    miller
    multipath-tools
    ngrok
    nmap
    nodePackages.svgo
    ocrmypdf
    ollama
    pdftk
    pkgs-unstable.nixfmt-rfc-style
    ranger
    ripgrep
    tesseract
    tokei
    tree
    units
    wol
    yt-dlp
    zip
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
