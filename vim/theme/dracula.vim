if exists("g:colors_name") && g:colors_name ==# 'dracula'
    finish
endif

let g:colors_name = 'dracula'
set termguicolors
set t_Co=256
set background=dark
colorscheme dracula
syntax on
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE guifg=Gray
