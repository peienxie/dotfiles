-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      ident = {
        animate = {
          enabled = false,
        },
      },
      input = {
        -- reference: https://github.com/folke/snacks.nvim/discussions/376
        win = {
          keys = {
            i_del_word = { "<C-w>", "delete_word", mode = "i" },
          },
          actions = {
            delete_word = function()
              return "<cmd>normal! diw<cr><right>"
            end,
          },
        },
      },
    },
  },
}
