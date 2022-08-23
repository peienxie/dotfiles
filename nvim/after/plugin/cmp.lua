vim.opt.completeopt = { "menu", "menuone", "noselect" }

local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "path" },
		{ name = "luasnip" },
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	preselect = cmp.PreselectMode.Item,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_kind",
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[lua]",
				buffer = "[buf]",
				path = "[path]",
				luasnip = "[snip]",
			},
		}),
	},
	experimental = {
		native_menu = false,
		ghost_text = false,
	},
})

if vim.g.colors_name == "dracula" then
	vim.cmd([[ highlight! link CmpItemAbbrDeprecated DraculaRed ]])
	vim.cmd([[ highlight! link CmpItemAbbrMatch DraculaCyan ]])
	vim.cmd([[ highlight! link CmpItemAbbrMatchFuzzy DraculaCyan ]])
end
