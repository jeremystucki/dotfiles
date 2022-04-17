HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd extendedglob notify
unsetopt beep

setopt hist_ignore_space

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/jeremy/.zshrc'
autoload -Uz compinit
compinit

export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

alias vi='vim'
alias ls='ls -lah'

alias g='git'
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

# SPACESHIP_GIT_STATUS_STASHED=''
# SPACESHIP_GRADLE_SHOW=false
# SPACESHIP_GRADLE_JVM_SHOW=false
# SPACESHIP_GIT_SHOW=false

# autoload -Uz promptinit
# promptinit
# prompt spaceship

setopt PROMPT_SUBST
source ~/git-prompt.sh # TODO
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true
export PS1='
%1~$(__git_ps1)
$ '

if [ "$(hostname)" = "volt" ]; then
    bindkey "^[[3~" delete-char
fi

if [ "$(hostname)" = "Jeremys-MacBook-Pro.local" ]; then
    export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
    export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

