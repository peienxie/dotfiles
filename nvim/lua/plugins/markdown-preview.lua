return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle" },
  keys = {
    { "<Leader>md", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle" },
  },
  init = function()
    -- set to 1, the nvim will auto close current preview window when change
    -- from markdown buffer to another buffer
    -- default: 1
    vim.g.mkdp_auto_close = 0
    -- set to 1, the vim will refresh markdown when save the buffer or
    -- leave from insert mode, default 0 is auto refresh markdown as you edit or
    -- move the cursor
    -- default: 0
    vim.g.mkdp_refresh_slow = 1
    -- recognized filetypes
    -- these filetypes will have MarkdownPreview... commands
    vim.g.mkdp_filetypes = { "markdown", "vimwiki" }
    -- set default theme (dark or light)
    -- By default the theme is define according to the preferences of the system
    vim.g.mkdp_theme = "dark"
  end,
}
