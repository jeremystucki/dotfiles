{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      copycat
      resurrect
      vim-tmux-navigator
      {
        plugin = sensible;
        extraConfig = ''
          # Workaround for https://github.com/tmux-plugins/tmux-sensible/issues/74
          set -g default-command '$SHELL'
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_current_text " #T"
          set -g @catppuccin_window_text " #T"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = open;
        extraConfig = ''
          set -g @open-S 'https://www.duckduckgo.com/?q='
        '';
      }
      {
        plugin = yank;
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

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      bind s choose-tree -s -O name

      set -g status-left ""
      set -g status-right-length 100
      set -g status-right "#{E:@catppuccin_status_session}"
    '';
  };

  programs.zsh.initContent = ''
    if [[ -n $TMUX ]]; then
      autoload -Uz add-zsh-hook

      tmux_report_cwd() {
        tmux select-pane -t "$TMUX_PANE" -T "$(basename $PWD)"
      }

      add-zsh-hook chpwd tmux_report_cwd
      tmux_report_cwd
    fi
  '';
}
