local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
	vim.notify("Failed to load plugin 'lspkind'", "error")
	return
end
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	vim.notify("Failed to load plugin 'nvim-cmp'", "error")
	return
end
local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	vim.notify("Failed to load plugin 'luasnip'", "error")
	return
end

cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }, { "i", "c" }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }, { "i", "c" }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }, { "i", "c" }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }, { "i", "c" }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_document_symbol" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path" },
		-- { name = "cmdline" },
		{ name = "luasnip" },
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	preselect = cmp.PreselectMode.Item,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_kind",
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lsp_document_symbol = "[LSPSym]",
				nvim_lua = "[lua]",
				buffer = "[buf]",
				path = "[path]",
				cmdline = "[cmd]",
				luasnip = "[snip]",
			},
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = false,
	},
})

vim.opt.completeopt = { "menu", "menuone", "noinsert" }
