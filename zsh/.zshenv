# default applications
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# XDG based directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh home
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
# zsh_history
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# golang
export GOROOT=/usr/local/go
export GOPATH=$XDG_DATA_HOME/go

# includes user's private bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# golang
PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# deduplicate path entry
export -U PATH
