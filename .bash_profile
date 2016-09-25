if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# general
alias ll="ls -la"
alias clera="clear"
alias vi=vim
alias clipboard="pbcopy"

export CLICOLOR=1
export export GPG_TTY=$(tty)

# git
alias pull="git pull"
alias push="git push"
alias commit="git commit"


if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi


# make autocomplete
complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

