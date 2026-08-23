return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Disable a keymap by setting it to false
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
}
