source ~/.config/nvim/common.vim
source ~/.config/nvim/plug.vim
source ~/.config/nvim/keymapping.vim
source ~/.config/nvim/autocmd.vim
source ~/.config/nvim/theme/dracula.vim

" some vim emulator of IDE like vscode and intelliJ do not fully support vim
" command, put those keymapping in another file and use 'exec' which is only
" picked up by vim
if has("nvim")
    exec "source ~/.config/nvim/advanced-keymapping.vim"
endif
