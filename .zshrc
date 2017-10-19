export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.fastlane/bin:$PATH"

autoload zmv

ZSH_THEME="agnoster"
ENABLE_CORRECTION="true"

plugins=(git brew)

source $ZSH/oh-my-zsh.sh

alias vi=/usr/local/bin/vim
alias ll="ls -la"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

