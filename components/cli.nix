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
    keyMode = "vi";
    plugins = [
      { plugin = pkgs.tmuxPlugins.catppuccin; }
      { plugin = pkgs.tmuxPlugins.copycat; }
      { plugin = pkgs.tmuxPlugins.resurrect; }
      { plugin = pkgs.tmuxPlugins.sensible; }
      { plugin = pkgs.tmuxPlugins.vim-tmux-navigator; }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.open;
        extraConfig = ''
          set -g @open-S 'https://www.duckduckgo.com/?q='
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.yank;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
    ];
    extraConfig = ''
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-style bg=white,fg=cyan

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
