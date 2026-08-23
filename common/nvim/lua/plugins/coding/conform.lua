return {
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cn", "<Cmd>ConformInfo<CR>", desc = "ConformInfo" },
    },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
