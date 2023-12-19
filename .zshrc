export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="candy"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export EDITOR='vim'

bindkey '`' autosuggest-accept
