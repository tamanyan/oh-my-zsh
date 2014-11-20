HISTFILE=~/.oh-my-zsh/log/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_nodups

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

# LMNtal
export LMNTAL_HOME="/Applications/LaViT2_8_6/lmntal"

# LS colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
