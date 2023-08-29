return {
  {
    "vimwiki/vimwiki",
    ft = { "markdown" },
    init = function()
      vim.g.vimwiki_list = {
        { path = "~/vimwiki/", syntax = "markdown", ext = ".md" },
      }
      -- automatically generate a level 1 header when creating a new wiki page.
      vim.g.vimwiki_auto_header = 1
      -- only set the filetype of markdown files inside a wiki directory
      vim.g.vimwiki_global_ext = 0
      -- the prettier markdown formatter will format the checkbox of completed task to lowercase x
      -- if use default value ' .oOX' here, syntax highlight and <C-Space> keymap won't work with the formatter
      vim.g.vimwiki_listsyms = " x"
    end,
  },
  {
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
  },
  {
    "ekickx/clipboard-image.nvim",
    ft = { "markdown" },
    cmd = { "PasteImg" },
    keys = {
      { "<Leader>mp", "<Cmd>PasteImg<CR>", desc = "Paste Image" },
    },
    opts = {
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
        affix = "![text](%s)",
      },
    },
  },
}
