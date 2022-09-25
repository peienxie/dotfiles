local ok, null_ls = pcall(require, "null-ls")
if not ok then
	vim.notify("Failed to load plugin 'null-ls'", "error")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local executable = function(expr)
	return function()
		return vim.fn.executable(expr) == 1
	end
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

local sources = {
	formatting.stylua.with({
		condition = executable("stylua"),
	}),
	formatting.black.with({
		extra_args = { "--fast" },
		condition = executable("black"),
	}),
	formatting.prettier.with({
		condition = executable("prettier"),
		filetypes = vim.tbl_extend("force", formatting.prettier.filetypes, {
			"vimwiki",
		}),
	}),
	diagnostics.flake8.with({
		extra_args = { "--max-line-length=88", "--ignore=E203" },
		condition = executable("flake8"),
	}),
}

null_ls.setup({
	on_attach = on_attach,
	sources = sources,
})
