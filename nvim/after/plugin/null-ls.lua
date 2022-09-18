local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local executable = function(expr)
	return vim.fn.executable(expr) == 1
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
		condition = function()
			return executable("stylua")
		end,
	}),
	formatting.black.with({
		extra_args = { "--fast" },
		condition = function()
			return executable("black")
		end,
	}),
	formatting.prettier.with({
		condition = function()
			return executable("prettier")
		end,
		filetypes = vim.tbl_extend("force", formatting.prettier.filetypes, {
			"vimwiki",
		}),
	}),
	diagnostics.flake8.with({
		extra_args = { "--max-line-length=88", "--ignore=E203" },
		condition = function()
			return executable("flake8")
		end,
	}),
}

null_ls.setup({
	on_attach = on_attach,
	sources = sources,
})
