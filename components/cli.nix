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
#    mouse = true; // TODO: Enable after next nix release
    keyMode = "vi";
    terminal = "screen-256color";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = ''
      bind -r C-h select-pane -L
      bind -r C-j select-pane -D
      bind -r C-k select-pane -U
      bind -r C-l select-pane -R

      set-option -g status-style bg=white,fg=cyan
      set -g mouse on
    '';
  };
}
