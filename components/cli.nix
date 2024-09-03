{ pkgs, pkgs-unstable, ... }:

{
  home.packages =
    with pkgs;
    [
      asciinema
      bat
      borgbackup
      caddy
      delta
      dogdns
      du-dust
      entr
      fd
      ffmpeg-full
      file
      ijq
      mani
      miller
      nmap
      nodePackages.svgo
      ocrmypdf
      ollama
      pdftk
      pkgs-unstable.nixfmt-rfc-style
      ranger
      ripgrep
      terraform
      tesseract
      tokei
      tree
      units
      xsv
      yt-dlp
      zip
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      multipath-tools
      ngrok
      wol
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
