#!/usr/bin/env zsh

# option
setopt print_eight_bit
setopt no_beep
setopt auto_cd
setopt auto_pushd

# history
HISTFILE=~/.oh-my-zsh/log/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_nodups

function mac_config() {
  # for Homebrew
  export PATH=/usr/local/sbin:$PATH
  export PATH=/usr/local/bin:$PATH

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

  # Python
  export PYTHONIOENCODING=UTF-8
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"

  # nvm
  source $HOME/.nvm/nvm.sh
  nvm use v0.11.12 > /dev/null

  # LMNtal
  export LMNTAL_HOME="/Applications/LaViT2_8_6/lmntal"

  export EDITOR=/usr/bin/vim
}

function linux_config() {

}

case ${OSTYPE} in
    darwin*)
        mac_config
        ;;
    linux*)
        linux_config
        ;;
esac

# LS colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# completion
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# alias
alias diff='colordiff -u'
alias sudo='sudo '
alias vi='vim'
alias resource='source ~/.zshrc'

# functions
function zssh() {
  ssh "$@" -t /bin/zsh
}

# percol
## sudo pip install percol
## create ~/.percol.d/rc.py
function percol-get-destination-from-cdr() {
    cdr -l | \
        sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
        percol --match-method migemo --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function percol-cdr() {
    local destination="$(percol-get-destination-from-cdr)"
    if [ -n "$destination" ]; then
        BUFFER="cd $destination"
        zle accept-line
    else
        zle reset-prompt
    fi
}
zle -N percol-cdr
bindkey '^@' percol-cdr

function percol_select_history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER             # move cursor
    zle -R -c                   # refresh
}
zle -N percol_select_history
bindkey '^R' percol_select_history

autoload -Uz is-at-least

if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi
