{
  pkgs,
  lib,
  ...
}: {
  imports = [./shell-common.nix];

  home.file."completion.zsh".source = ../resources/completion.zsh;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      ignoreSpace = true;
      save = 1000000;
      size = 1000000;
    };

    initContent =
      ''
        setopt PROMPT_SUBST

        source ~/completion.zsh

        export GIT_PS1_SHOWDIRTYSTATE=true
        export GIT_PS1_SHOWUNTRACKEDFILES=true
        export GIT_PS1_SHOWCOLORHINTS=true

        export PS1=$'\n%1~$(__git_ps1)\n$ '

        autoload edit-command-line
        zle -N edit-command-line
        bindkey '^v' edit-command-line

        bindkey '^a' beginning-of-line
        bindkey '^e' end-of-line
        bindkey '^n' clear-screen

        bindkey '^[[3~' delete-char

        eval "$(${pkgs.fnm}/bin/fnm env --use-on-cd --shell zsh)"
      ''
      + lib.optionalString pkgs.stdenv.isDarwin ''
        if [[ -x /opt/homebrew/bin/brew ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';
  };
}
