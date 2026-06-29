ZSH_THEME="powerlevel10k/powerlevel10k"
# determine current os type
IS_MACOS="" && [[ "$OSTYPE" == "darwin"* ]] && IS_MACOS="true"
IS_LINUX="" && [[ "$OSTYPE" == "linux-gnu" ]] && IS_LINUX="true"

# zsh_history
export HISTFILE="$XDG_STATE_HOME/zsh/history"
# oh-my-zsh home
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# golang
[[ -x "/opt/homebrew/bin/brew" ]] && \
  export GOROOT="$(/opt/homebrew/bin/brew --prefix go)/libexec" || \
  export GOROOT="/usr/lib/go"
export GOPATH="$XDG_DATA_HOME/go"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# python, ipython, and jupyter
# https://viliampucik.wordpress.com/2021/01/11/xdg-base-directory-compliant-python_history/
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonstartup.py"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
# node repl history
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
# npm config file ocation
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# java
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
# gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# ripgrep config file
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# terminal profiles
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# fzf default find command including hidden but not .git folder
# https://github.com/junegunn/fzf/issues/337
export FZF_DEFAULT_COMMAND='rg --hidden --files --glob "!.git"'

# run testcontainer-java with colima
if [[ $IS_MACOS == "true" ]] && \
  [[ -x "/opt/homebrew/bin/brew" ]] && [[ ! -z "$(/opt/homebrew/bin/brew list colima -v 2>/dev/null)" ]]; then
  export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
  export DOCKER_HOST="unix://$XDG_CONFIG_HOME/colima/default/docker.sock"
fi

# Aliases
for file in $ZDOTDIR/aliases/*.zsh
do
  source "$file"
done

# Custom functions
for file in $ZDOTDIR/functions/*.zsh
do
  source "$file"
done

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
P10K_CONFIG_FILE="$ZDOTDIR/themes/p10k.zsh"
[[ ! -f $P10K_CONFIG_FILE ]] || source $P10K_CONFIG_FILE

# Automaticlly install oh-my-zsh custom plugins and themes
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && {
  echo -n "Clone the zsh-autosuggestions plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions >/dev/null 2>&1
  echo "Done"
}
# [[ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ]] && {
#   echo -n "Clone the zsh-z plugin..."
#   git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z >/dev/null 2>&1
#   echo "Done"
# }
[[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]] && {
  echo -n "Clone the powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k >/dev/null 2>&1
  echo "Done"
}

# Which plugins would you like to load?
plugins=(git kubectl minikube docker zsh-autosuggestions)

# Variables and corresponding directories for oh-my-zsh
[[ ! -d "$XDG_DATA_HOME/zsh" ]] && mkdir -p "$XDG_DATA_HOME/zsh"
# ZSHZ_DATA="$XDG_DATA_HOME/zsh/zsh-z-history"
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

zstyle ':completion:*' list-colors
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Initialize oh-my-zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh" || echo "Can't find oh-my-zsh config file: $ZSH/oh-my-zsh.sh"

# initialize zoxide
eval "$(zoxide init zsh)"
# 
# Detect the type of operating system and load the appropriate fzf configuration files
if [[ $IS_LINUX == "true" ]]; then
  # source fzf keybindings and completion
  [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  [[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]] && source "/usr/share/doc/fzf/examples/completion.zsh"
elif [[ $IS_MACOS == "true" ]]; then
  [[ -f "$XDG_CONFIG_HOME/fzf/fzf.zsh" ]] && source "$XDG_CONFIG_HOME/fzf/fzf.zsh"
fi

# Setup homebrew environment
[[ -x "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Initialize sdkman
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
# Initialize nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# My personal bin
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"

# golang
PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

# rust
PATH="$CARGO_HOME/bin:$PATH"

# deduplicate path entry
export -U PATH
