local M = {}

M.setup = function()
	local ok, mason = pcall(require, "mason")
	if not ok then
		vim.notify("Failed to load plugin 'mason'", "error")
		return
	end

	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

return M
