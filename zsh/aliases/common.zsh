# Print each PATH entry on a separate line
alias path="echo -e \"\${PATH//:/\\n}\""

# Python
alias py=python3
alias python=python3
alias ipy=ipython

# fzf then cd the result has been selected
alias f='cd $(fd --type directory | fzf)'

