
# https://www.quora.com/What-is-the-most-useful-bash-script-that-you-have-ever-written/answer/Danish-Pruthi?ch=10&oid=93360685&share=be33bcbf&srid=uPHegR&target_type=answer
function extract() {
    if [[ -f $1 ]] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar Jxvf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       rar x $1       ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1 ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function tmux-sessionizer() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        echo "missing target name"
        return -1
    fi
    tmux_session_name=`basename $selected | tr . _`
    tmux switch-client -t $tmux_session_name
    if [[ $? -eq 0 ]]; then
        return
    fi
    # create new session
    tmux new-session -c $selected -d -s $tmux_session_name && \
        tmux switch-client -t $tmux_session_name || \
        tmux new -c $selected -A -s $tmux_session_name
}

# fuzzy cd
function cdf() { cd *$1*/ } # stolen from @topfunky

# zshz with fzf
function zf() {
    if ! type 'zshz' 2>/dev/null | grep -q 'function'
    then
        echo "zshz is not found."
        return -1
    fi
    if [[ "$#" -eq 1 ]]; then
        zshz "$@"
        return
    fi

    if [[ -x "$(command -v fzf)" ]]; then
        zshz $(zshz | fzf)
    else
        zshz
    fi
}
