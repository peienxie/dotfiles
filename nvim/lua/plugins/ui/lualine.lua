local function is_lsp_actived()
  local clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
  return clients and #clients > 0
end

local function get_lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  -- local status = {}
  -- for _, msg in pairs(messages) do
  --   table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  -- end
  local spinners = { "⠋", "⠙", "⠸", "⠴", "⠦", "⠇" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  -- return table.concat(status, " | ") .. " " .. spinners[frame + 1]
  return spinners[frame + 1]
end

local function get_lsp_name()
  local clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
  if clients and #clients > 0 then
    local names = {}
    for _, lsp in ipairs(clients) do
      table.insert(names, lsp.name)
    end
    return table.concat(names, ", ")
  else
    return ""
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = require("lazyvim.config").icons

      return {
        options = {
          component_separators = "",
          section_separators = "",
          disabled_filetypes = {
            "undotree",
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "filename",
              path = 1,
              symbols = { modified = "  ", readonly = "", unnamed = "" },
            },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
            },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = {
                fg = Snacks.util.color("Statement"),
              },
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = {
                fg = Snacks.util.color("Constant"),
              },
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = {
                fg = Snacks.util.color("Debug"),
              },
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = {
                fg = Snacks.util.color("Special"),
              },
            },
            -- {
            --   "diff",
            --   symbols = {
            --     added = icons.git.added,
            --     modified = icons.git.modified,
            --     removed = icons.git.removed,
            --   },
            -- },
            {
              function()
                return get_lsp_name()
              end,
              cond = function()
                return is_lsp_actived()
              end,
            },
          },
          lualine_y = {
            { "encoding" },
            {
              "fileformat",
              icons_enabled = true,
              symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
            },
            { "filetype", icons_enabled = false },
          },
          lualine_z = {
            { "location", padding = 1 },
          },
        },
        extensions = { "neo-tree", "lazy", "nvim-dap-ui", "quickfix" },
      }
    end,
  },
}
