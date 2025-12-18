{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs;
    [
      asciinema
      borgbackup
      caddy
      claude-code
      csvlens
      dogdns
      dust
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
      opencode
      pdfcpu
      qrencode
      ranger
      ripgrep
      ruby
      tesseract
      tokei
      tree
      units
      uv
      watchman
      xan
      xmlstarlet
      yt-dlp
      zip
    ]
    ++ lib.optionals stdenv.isDarwin [
      azure-cli
      fastlane
      gnused
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

  home.shellAliases = {
    cat = "bat";
    c = "clear -x";
    g = "git";
    base64 = "${pkgs.coreutils}/bin/base64 -w 0";
    clip =
      if pkgs.stdenv.isDarwin
      then "pbcopy"
      else "xclip -selection c";
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
