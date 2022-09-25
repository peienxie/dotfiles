local ok, clipboard_image = pcall(require, "clipboard-image")
if not ok then
	vim.notify("Failed to load plugin 'clipboard-image'", "error")
	return
end

clipboard_image.setup({
	-- Default configuration for all filetype
	default = {
		img_dir = { "%:p:h", "img" },
		img_dir_txt = "img",
		img_name = function()
			return os.date("%Y-%m-%d-%H-%M-%S")
		end, -- Example result: "2021-04-13-10-04-18"
	},
	-- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
	-- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
	-- Missing options from `markdown` field will be replaced by options from `default` field
	vimwiki = {
		affix = "![](%s)",
	},
})

-- TODO: add a keymap to call :PasteImg and move cursor to the center of brackets (markdown only?) ![|]($img_path)
