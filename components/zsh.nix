{ pkgs, ... }:

{
  home.file."git-prompt.sh".source = ../resources/git-prompt.sh;
  home.file."completion.zsh".source = ../resources/completion.zsh;

  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableSyntaxHighlighting = true;

    history = {
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
    };

    initExtra = ''
      setopt PROMPT_SUBST
      source ~/git-prompt.sh

      source ~/completion.zsh

      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWCOLORHINTS=true

      export PS1=$'\n%1~$(__git_ps1)\n$ '
      export EDITOR=vi
      export LESS=-iR

      alias c='clear -x'

#      ZVM_VI_EDITOR=vi
#
#      autoload edit-command-line
#      zle -N edit-command-line
#
#      TODO: Figure out how to do this properly
#      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^v' edit-command-line

      bindkey '^a' beginning-of-line
      bindkey '^e' end-of-line
      bindkey '^n' clear-screen
    '';
  };
}
