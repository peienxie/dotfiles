return {
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
}
