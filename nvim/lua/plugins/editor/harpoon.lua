return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
      local keys = {
        {
          "<leader>fa",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>fh",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 10 do
        table.insert(keys, {
          "<leader>" .. i % 10,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "which_key_ignore",
        })
      end
      return keys
    end,
  },
}
