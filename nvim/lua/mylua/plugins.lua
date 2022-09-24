-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- Install plugins here
return packer.startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-- themes
	use({ "gruvbox-community/gruvbox" })
	use({ "dracula/vim", as = "dracula" })
	use({ "Luxed/ayu-vim" })
	-- use({ "ayu-theme/ayu-vim" })

	use({ "vim-airline/vim-airline" })
	use({ "airblade/vim-rooter" })
	use({ "fatih/vim-go" })
	use({ "tpope/vim-surround" })
	use({
		"jiangmiao/auto-pairs",
		config = function()
			-- only jump to close pair on the same line
			vim.g.AutoPairsMultilineClose = 0
		end,
	})
	use({ "tpope/vim-sleuth" })
	use({
		"mbbill/undotree",
		config = function()
			-- don't open diff window on default
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_WindowLayout = 2
			local nnoremap = require("mylua.utils.keymap").nnoremap
			nnoremap("<leader>eu", ":UndotreeToggle<CR>")
		end,
	})

	-- Git integration
	use({ "TimUntersberger/neogit" })
	use({ "akinsho/git-conflict.nvim" })
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })

	-- ipython terminal
	use({ "jpalardy/vim-slime" })
	use({ "hanschen/vim-ipython-cell" })
	use({ "mhinz/vim-startify" })

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/playground" })
	use({ "nvim-treesitter/nvim-treesitter-context" })

	-- telescope
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "ray-x/lsp_signature.nvim" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- autocompletion
	use({ "hrsh7th/nvim-cmp" })
	use({ "onsails/lspkind-nvim" })
	-- sources of nvim-cmp
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol" })
	-- snip engine and cmp source
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })

	use({ "folke/lua-dev.nvim" })

	use({ "kyazdani42/nvim-tree.lua" })
	use({ "kyazdani42/nvim-web-devicons" })

	use({ "akinsho/bufferline.nvim" })

	use({ "numToStr/Comment.nvim" })

	use({ "akinsho/toggleterm.nvim" })

	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
	use({ "ekickx/clipboard-image.nvim" })

	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = { { path = "~/vimwiki/", syntax = "markdown", ext = ".md" } }
			-- automatically generate a level 1 header when creating a new wiki page.
			vim.g.vimwiki_auto_header = 1
			-- only set the filetype of markdown files inside a wiki directory
			vim.g.vimwiki_global_ext = 0
			-- the prettier markdown formatter will format the checkbox of completed task to lowercase x
			-- if use default value ' .oOX' here, syntax highlight and <C-Space> keymap won't work with the formatter
			vim.g.vimwiki_listsyms = " x"
		end,
	})
end)
