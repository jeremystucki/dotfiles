{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs;
    [
      asciinema
      bat
      borgbackup
      caddy
      csvlens
      delta
      dogdns
      du-dust
      entr
      fd
      ffmpeg-full
      file
      fnm
      google-cloud-sdk
      ijq
      libwebp
      mani
      miller
      nmap
      nodePackages.svgo
      nvd
      ocrmypdf
      ollama
      pdfcpu
      qrencode
      ranger
      ripgrep
      ruby
      tesseract
      tokei
      tree
      units
      watchman
      xan
      yt-dlp
      zip
    ]
    ++ lib.optionals (stdenv.isDarwin) [
      azure-cli
      pkgs-unstable.swiftformat
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      multipath-tools
      ngrok
      screen
      wol
      xclip
    ];

  programs.bat.enable = true;
  programs.jq.enable = true;
  programs.lsd.enable = true;
  programs.pandoc.enable = true;
  programs.zoxide.enable = true;

  programs.zsh.shellAliases = {
    cat = "bat";
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

  home.sessionVariables."RIPGREP_CONFIG_PATH" = builtins.toFile ".ripgreprc" ''
    --hidden
    --glob=!.git/*
  '';
}

