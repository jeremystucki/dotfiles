{ ... }:

{
  home.file."completion.zsh".source = ../resources/completion.zsh;

  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      style = "compact";
      show_help = false;
      inline_height = 20;
      keymap_mode = "vim-insert";
    };
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
    };

    initExtra = ''
      setopt PROMPT_SUBST

      source ~/completion.zsh

      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWCOLORHINTS=true

      export PS1=$'\n%1~$(__git_ps1)\n$ '
      export EDITOR=vi
      export LESS=-iR

      alias c='clear -x'
      alias clip='xclip -selection c'
      alias base64='base64 -w 0'

      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^v' edit-command-line

      bindkey '^a' beginning-of-line
      bindkey '^e' end-of-line
      bindkey '^n' clear-screen

      bindkey '^[[3~' delete-char
    '';
  };
}
