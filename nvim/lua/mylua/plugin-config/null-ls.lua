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
		condition = executable("black"),
		extra_args = { "--fast" },
	}),
	formatting.prettier.with({
		condition = executable("prettier"),
		extra_filetypes = { "vimwiki" },
	}),
	formatting.google_java_format.with({
		condition = executable("google-java-format"),
		extra_args = { "--aosp" },
	}),
	diagnostics.flake8.with({
		condition = executable("flake8"),
		extra_args = { "--max-line-length=88", "--ignore=E203" },
	}),
}

null_ls.setup({
	on_attach = on_attach,
	sources = sources,
})
