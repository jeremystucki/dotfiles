HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd extendedglob notify
unsetopt beep

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/jeremy/.zshrc'
autoload -Uz compinit
compinit

alias vi='vim'

if [ "$(hostname)" = "volt" ]; then
    alias ll='ls -lah --color'
fi

if [ "$(hostname)" = "Jeremys-MacBook-Pro.local" ]; then
    alias ll='ls -lahG'
fi

alias grep='grep --color'

alias gst='git status'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gam='git commit --amend --no-edit'

alias ssh='TERM=xterm-256color ssh'

alias cat='bat'

export PATH=$PATH:$HOME/.cargo/bin

SPACESHIP_GIT_STATUS_STASHED=''

autoload -Uz promptinit
promptinit
prompt spaceship

if [ "$(hostname)" = "volt" ]; then
    bindkey "^[[3~" delete-char
fi

if [ "$(hostname)" = "Jeremys-MacBook-Pro.local" ]; then
    export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
    export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi
