{
  home.file."git-prompt.sh".source = ../git-prompt.sh;

  programs.zsh = {
    enable = true;

    enableSyntaxHighlighting = true;

    history = {
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
    };

    shellAliases = {
      ll = "ls -lah";
    };

    initExtra = ''
      setopt PROMPT_SUBST
      source ~/git-prompt.sh

      export GIT_PS1_SHOWDIRTYSTATE=true
      export GIT_PS1_SHOWUNTRACKEDFILES=true
      export GIT_PS1_SHOWCOLORHINTS=true

      export PS1=$'\n%1~$(__git_ps1)\n$ '

      if [ \"$(hostname)\" = 'volt' ]; then
          bindkey '^[[3~' delete-char # TODO: Figure out why I did this
      fi
    '';
  };
}
