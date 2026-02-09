return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "gK", false },
            { "<C-k>", false, mode = "i" },
            { "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>" },
            { "gl", "<Cmd>lua vim.diagnostic.open_float()<CR>" },
            { "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>" },
            { "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>" },
            { "gR", "<Cmd>lua vim.lsp.buf.rename()<CR>" },
          },
        },
        lua_ls = {
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeys[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        bashls = {},
        html = {},
        cssls = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cn", "<Cmd>ConformInfo<CR>", desc = "ConformInfo" },
    },
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" }, "markdownlint" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufReadPre",
    -- init = function()
    --   vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    --     callback = function()
    --       require("lint").try_lint()
    --     end,
    --   })
    -- end,
    config = function(_, opts)
      local function setup_linters(linters)
        for ft, linter in pairs(linters) do
          if opts.linters_by_ft[ft] == nil then
            opts.linters_by_ft[ft] = linter
          else
            vim.notify(
              string.format(
                "%s: override linter %s with %s",
                ft,
                vim.inspect(opts.linters_by_ft[ft]),
                vim.inspect(linter)
              ),
              vim.log.levels.WARN
            )
            opts.linters_by_ft[ft] = linter
          end
        end
      end

      setup_linters({
        go = { "golangcilint" },
        --go = { "revive" },
        bash = { "shellcheck" },
        sh = { "shellcheck" },
        html = { "htmlhint" },
      })
    end,
  },
}
