return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        { filter = { event = "msg_show", kind = "search_count" }, skip = true },
        {
          filter = {
            event = "msg_show",
            any = {
              -- saving files
              { find = "%d+L, %d+B" },
              -- undo/redo
              { find = "; before #%d+" },
              { find = "; after #%d+" },
              { find = "^Already at oldest change" },
              { find = "^Already at newest change" },
              -- yank/paste/cut in visual mode
              { find = "%d lines yanked" },
              { find = "%d more lines" },
              { find = "%d fewer lines" },
            },
          },
          view = "mini",
        },
        -- search patterns
        { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },
        { filter = { event = "msg_show", find = "^[/?]." }, skip = true },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline",
      },
      messages = { view_search = false },
    },
  },
}
