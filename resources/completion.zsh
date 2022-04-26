# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._]=** r:|=** l:|=*'
zstyle :compinstall filename '/home/jeremy/GitHub/jeremystucki/dotfiles/resources/completion.zsh'

autoload -Uz compinit
compinit
# End of lines added by compinstall
