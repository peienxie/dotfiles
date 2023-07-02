return {
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
}
