local luasnip = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end)

luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
