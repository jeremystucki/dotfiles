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

alias ll='ls -lah --color'
alias grep='grep --color'

alias gst='git status'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
alias gd='git diff'
alias gco='git checkout'
alias gam='git commit --amend --no-edit'

alias ssh='TERM=xterm-color ssh'

alias cat='bat'

autoload -Uz promptinit
promptinit
prompt spaceship

if [ "$(hostname)" = "volt" ]; then
    bindkey "^[[3~" delete-char
fi
