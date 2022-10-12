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
# skip compinit call in /etc/zsh/zshrc, the compinit will be called in oh-my-zsh.sh
skip_global_compinit=1

# oh-my-zsh home
export ZSH=$XDG_CONFIG_HOME/oh-my-zsh

# golang
export GOROOT=/usr/local/go
export GOPATH=$XDG_DATA_HOME/go

# rust
export CARGO_HOME=$XDG_DATA_HOME/cargo
export RUSTUP_HOME=$XDG_DATA_HOME/rustup

# python, ipython, and jupyter
# https://viliampucik.wordpress.com/2021/01/11/xdg-base-directory-compliant-python_history/
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonstartup.py
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# node repl history
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node/node_repl_history
# npm config file ocation
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# java
export JAVA_HOME=/usr/lib/jvm/default-java
export GRADLE_HOME=/opt/gradle/latest
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle

# ripgrep config file
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/ripgreprc

# terminal profiles
export TERMINFO=$XDG_DATA_HOME/terminfo
export TERMINFO_DIRS=$XDG_DATA_HOME/terminfo:/usr/share/terminfo

# fzf default find command including hidden but not .git folder
# https://github.com/junegunn/fzf/issues/337
export FZF_DEFAULT_COMMAND='rg --hidden --files --glob "!.git"'

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
PATH="$CARGO_HOME/bin:$PATH"

# java
PATH="$JAVA_HOME/bin:$PATH"
PATH="$GRADLE_HOME/bin:$PATH"

# deduplicate path entry
export -U PATH
