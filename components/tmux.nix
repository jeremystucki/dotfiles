{ pkgs, ... }:

{
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
          set -g @catppuccin_left_separator "█"
          set -g @catppuccin_right_separator "█"
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

      set-option -g status-style bg=white,fg=cyan

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind s choose-tree -s -O name
    '';
  };
}
