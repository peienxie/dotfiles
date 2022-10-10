-- once any lsp config become complex should move it into a separated file.
return {
	ccls = {
		init_options = {
			cache = { directory = vim.fn.expand("$HOME/.cache/ccls-cache") },
		},
	},
	--clangd = {
	--	cmd = {
	--		"clangd",
	--		"--background-index",
	--		"--clang-tidy",
	--	},
	--},
	pyright = {},
	gopls = {},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	},
	vimls = {},
	dockerls = {},
	yamlls = {},
	jsonls = {},
}
