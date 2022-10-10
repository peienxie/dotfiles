local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	vim.notify("Failed to load plugin 'lspconfig'", "error")
	return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("v", "<leader>gf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bold = true, bg = "Grey" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { bold = true, bg = "Grey" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bold = true, bg = "Grey" })
		local group = vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = true,
		})
		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	vim.notify("Failed to load plugin 'cmp_nvim_lsp'")
else
	capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
end

local lsp_server_configs = {
	ccls = {},
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

local extend_lsp_config = function(default)
	return vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, default)
end

local setup_lsp_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	lspconfig[server].setup(extend_lsp_config(config))
end

local get_lsp_servers = function()
	local lsp_servers = {}
	for server in pairs(lsp_server_configs) do
		table.insert(lsp_servers, server)
	end
	return lsp_servers
end

-- It's important that you set up the plugins in the following order:
-- mason.nvim --> mason-lspconfig.nvim --> lspconfig
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	vim.notify("Failed to load plugin 'mason-lspconfig'", "error")
else
	mason_lspconfig.setup({
		ensure_installed = get_lsp_servers(),
		automatic_installation = true,
	})
end

-- Loop through the servers listed above.
for server, config in pairs(lsp_server_configs) do
	setup_lsp_server(server, config)
end

-- make diagnostic icon looks better
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
-- vim.o.updatetime = 500
-- local group = vim.api.nvim_create_augroup("lsp_diagnostic_hover", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 	group = group,
-- 	callback = vim.diagnostic.open_float(nil, { focus = false }),
-- })

local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_ok then
	vim.notify("Failed to load plugin 'lsp_signature'", "error")
else
	lsp_signature.setup({
		hint_enable = false,
		hint_prefix = "",
		handler_opts = {
			border = "none", -- double, rounded, single, shadow, none
		},
		always_trigger = true,
		toggle_key = "<C-k>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	})
end
