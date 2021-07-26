let mapleader = " "

" escape
inoremap jj <Esc>
inoremap <C-c> <Esc>
nnoremap <silent> <C-c> :nohl<CR>

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
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
nnoremap <A-j> <Esc>:m .+1<CR>==
nnoremap <A-k> <Esc>:m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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
nnoremap <leader>ss :split<Return><C-w>w
nnoremap <leader>sv :vsplit<Return><C-w>w

