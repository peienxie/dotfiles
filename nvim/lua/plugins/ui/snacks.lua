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
      terminal = {
        win = {
          keys = {
            -- Use <alt> to navigate windows instead
            nav_h = { "<A-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<A-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<A-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<A-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
    },
  },
}
