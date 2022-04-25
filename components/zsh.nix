{
  home.file."git-prompt.sh".source = ../resources/git-prompt.sh;
  home.file."completion.zsh".source = ../resources/completion.zsh;

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
    '';
  };
}
