{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  home.packages = with pkgs;
    [
      asciinema
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
    ++ lib.optionals (pkgs.stdenv.isDarwin) [
      azure-cli
      gnused
      pkgs-unstable.swiftformat
    ]
    ++ lib.optionals (!pkgs.stdenv.isDarwin) [
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
  
  programs.fzf = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      style = "compact";
      show_help = false;
      inline_height = 20;
      keymap_mode = "vim-insert";
    };
  };
  
  programs.zoxide = {
    enable = true;
  };

  home.shellAliases = lib.mkMerge [
    {
      cat = "bat";
      c = "clear -x";
      base64 = "${pkgs.coreutils}/bin/base64 -w 0";
    }
    (lib.optionalAttrs pkgs.stdenv.isDarwin {
      clip = "pbcopy";
    })
    (lib.optionalAttrs pkgs.stdenv.isLinux {
      clip = "xclip -selection c";
    })
  ];

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

