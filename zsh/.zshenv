# Language
export LANG="en_US.UTF-8"

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# XDG based directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh home
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Skip `compinit` command call in /etc/zsh/zshrc, it will be called in oh-my-zsh.sh later
skip_global_compinit=1

export SHELL_SESSIONS_DISABLE=1
