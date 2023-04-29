{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    dogdns
    fd
    ffmpeg-full
    ranger
    ripgrep
    tealdeer
    tokei
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

  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = [
      { plugin = pkgs.tmuxPlugins.catppuccin; }
      { plugin = pkgs.tmuxPlugins.sensible; }
      { plugin = pkgs.tmuxPlugins.vim-tmux-navigator; }
    ];
    extraConfig = ''
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-style bg=white,fg=cyan

      set -g mouse on

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
