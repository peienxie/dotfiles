call plug#begin("~/.vim/plugged")

Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

if has("nvim")
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    Plug 'mhinz/vim-signify'

    Plug 'neovim/nvim-lspconfig'
endif

call plug#end()

