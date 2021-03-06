let mapleader = " "

" escape
inoremap jj <Esc>
inoremap <C-c> <Esc>
nnoremap <silent> <C-c> :nohl<CR>

" show the highlight group of symbol under cursor
nnoremap <F10> :TSHighlightCapturesUnderCursor<CR>

" disable some default keymapping which I don't wanna use
nnoremap Q <nop>
nnoremap q: <nop>

" make Y work the same as D and C
nnoremap Y y$

" keep cursor center when jumpping search result
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" source myvimrc
nnoremap <leader><CR> :so $MYVIMRC<CR>

" yank to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
" replace current selected text
vnoremap <leader>dp "_dP

" delete without copying to clipboard
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap x "_x
vnoremap x "_xgv

" search/replace for visually hightlighted text
vnoremap <C-f> "hy<Esc>/<C-r>h<CR>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" move current line/block up and down
inoremap <A-j> <Esc>:m .+1<CR>gi
inoremap <A-k> <Esc>:m .-2<CR>gi
nnoremap <A-j> <Esc>:m .+1<CR>
nnoremap <A-k> <Esc>:m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-k> :m '<-2<CR>gv

" indent but remain in visual mode
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" move around windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>q <C-w>q
nnoremap <leader>ss :split<CR>
nnoremap <leader>sv :vsplit<CR>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprev<CR>

