setopt CDABLE_VARS

export ZSH="$HOME/.oh-my-zsh"

export EDITOR=vim
export LANG="en_US.UTF-8"

export PATH="$PATH:$HOME/.cargo/bin:$HOME/.poetry/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin";
export GPG_TTY=$(tty)

autoload zmv

ZSH_THEME="agnoster"
# ENABLE_CORRECTION="true"

plugins=(git brew)

source $ZSH/oh-my-zsh.sh

alias vi=/usr/local/bin/vim
alias ll="ls -la"
alias c=clear
alias clera=clear
alias git=hub

clone() {
    username=$1
    repository=$2

    if [ -d "~github/$username/$repository" ]; then
        echo "Repository already exists"
        return 1;
    fi

    git clone git@github.com:$username/$repository.git ~github/$username/$repository

    if [ "$username" = "myelin-ai" ]; then
        cat ~/.myelin_gitconfig >> ~github/$username/$repository/.git/config
    fi
}

hash -d github=~/GitHub
hash -d myelin-ai=~github/myelin-ai

