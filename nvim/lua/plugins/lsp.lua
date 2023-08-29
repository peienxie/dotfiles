return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Update LSP keymaps
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gK", false }
      keys[#keys + 1] = { "<C-k>", false, mode = "i" }
      -- disable a keymap
      keys[#keys + 1] = { "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>" }
      keys[#keys + 1] = { "gl", "<Cmd>lua vim.diagnostic.open_float()<CR>" }
      keys[#keys + 1] = { "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>" }
      keys[#keys + 1] = { "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>" }
      keys[#keys + 1] = { "gR", "<Cmd>lua vim.lsp.buf.rename()<CR>" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
        ansiblels = {},
        bashls = {},
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
          },
        },
        dockerls = {},
        gopls = {},
        jsonls = {},
        pyright = {},
        yamlls = {},
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    keys = {
      { "<Leader>cn", "<Cmd>NullLsInfo<CR>", desc = "NullLs" },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      local sources = {
        -- Linters
        nls.builtins.diagnostics.flake8.with({
          extra_args = { "--max-line-length=88", "--ignore=E203" },
        }),
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.diagnostics.markdownlint.with({
          extra_filetypes = { "vimwiki" },
        }),
        nls.builtins.diagnostics.shellcheck,

        -- Formatters
        nls.builtins.formatting.black.with({
          extra_args = { "--fast" },
        }),
        nls.builtins.formatting.google_java_format.with({
          -- use 4 spaces
          -- extra_args = { "--aosp" },
        }),
        -- nls.builtins.formatting.prettier.with({
        --   extra_filetypes = { "vimwiki" },
        -- }),
        nls.builtins.formatting.prettierd.with({
          extra_filetypes = { "vimwiki" },
        }),
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.stylua,
      }
      opts.sources = sources
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
}
