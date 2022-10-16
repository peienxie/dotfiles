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
	vim.notify("packer ")
	return
end

-- Install plugins here
return packer.startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-- Colorschemes
	use({ "gruvbox-community/gruvbox", disable = true })
	use({ "dracula/vim", as = "dracula", disable = true })
	-- use({ "ayu-theme/ayu-vim" })
	use({
		"Luxed/ayu-vim",
		config = function()
			require("mylua.plugin-config.ayu")
		end,
	})

	-- Statusline
	use({
		"hoob3rt/lualine.nvim",
		config = function()
			require("mylua.plugin-config.lualine")
		end,
	})

	-- Buffers and Tabs
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("mylua.plugin-config.bufferline")
		end,
	})

	-- File Explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
		},
		config = function()
			require("mylua.plugin-config.nvim-tree")
		end,
	})

	-- Session management
	use({
		"mhinz/vim-startify",
		config = function()
			require("mylua.plugin-config.startify")
		end,
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("mylua.plugin-config.toggleterm")
		end,
	})
	-- ipython terminal
	use({ "jpalardy/vim-slime" })
	use({ "hanschen/vim-ipython-cell", ft = "python" })

	-- Git integration
	use({
		"TimUntersberger/neogit",
		requires = { "sindrets/diffview.nvim" },
		config = function()
			require("mylua.plugin-config.neogit")
		end,
	})
	use({
		"akinsho/git-conflict.nvim",
		config = function()
			require("mylua.plugin-config.git-conflict")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("mylua.plugin-config.diffview")
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("mylua.plugin-config.gitsigns")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			{ "nvim-treesitter/playground" },
			{ "nvim-treesitter/nvim-treesitter-context" },
		},
		config = function()
			require("mylua.plugin-config.treesitter")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("mylua.plugin-config.treesitter-context")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("mylua.plugin-config.telescope")
		end,
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "ray-x/lsp_signature.nvim" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			require("mylua.lsp").setup()
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("mylua.plugin-config.null-ls")
		end,
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- icons for completeion items
			{ "onsails/lspkind-nvim" },
			-- sources of nvim-cmp
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			require("mylua.plugin-config.cmp")
		end,
	})
	-- snip engine and cmp source
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("mylua.plugin-config.luasnip")
		end,
	})

	-- DAP
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("mylua.dap").setup()
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		require = { "mfussenegger/nvim-dap" },
	})
	use({
		"leoluz/nvim-dap-go",
		require = { "mfussenegger/nvim-dap" },
	})
	use({
		"mfussenegger/nvim-dap-python",
		require = { "mfussenegger/nvim-dap" },
	})

	-- Neovim lua development
	use({
		"folke/neodev.nvim",
		config = function()
			require("mylua.plugin-config.neodev")
		end,
	})

	-- Programming language related
	use({ "fatih/vim-go", ft = "go" })
	use({ "mfussenegger/nvim-jdtls" })

	-- Editing
	use({ "tpope/vim-sleuth" })
	use({ "tpope/vim-surround" })
	use({
		"jiangmiao/auto-pairs",
		config = function()
			require("mylua.plugin-config.auto-pairs")
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("mylua.plugin-config.comment")
		end,
	})

	-- Other utility
	use({ "airblade/vim-rooter", disable = true })
	use({
		"mbbill/undotree",
		config = function()
			require("mylua.plugin-config.undotree")
		end,
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		config = function()
			require("mylua.plugin-config.markdown-preview")
		end,
	})
	use({
		"ekickx/clipboard-image.nvim",
		config = function()
			require("mylua.plugin-config.clipboard-image")
		end,
	})
	use({
		"vimwiki/vimwiki",
		config = function()
			require("mylua.plugin-config.vimwiki")
		end,
	})
end)
