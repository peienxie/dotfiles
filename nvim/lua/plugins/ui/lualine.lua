return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local icons = LazyVim.config.icons

      local diff = {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      }

      local lsp_servers = {
        function()
          local clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
          return clients and #clients > 0
        end,
        cond = function()
          local clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
          if clients and #clients > 0 then
            local names = {}
            for _, lsp in ipairs(clients) do
              table.insert(names, lsp.name)
            end
            return table.concat(names, ",")
          else
            return ""
          end
        end,
      }

      local navic_location = {
        function()
          return require("nvim-navic").get_location()
        end,
        cond = function()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available() and vim.o.columns > 160
        end,
      }

      return {
        options = {
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { "undotree" },
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
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
            navic_location,
          },

          lualine_x = {
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            lsp_servers,
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
            {
              "searchcount",
              maxcount = 99999,
              fmt = function(str)
                return str == "[0/0]" and nil or str
              end,
              padding = { left = 1 },
            },
            { "location", padding = 1 },
          },
        },
        tabline = {
          lualine_z = { { "tabs" } },
        },
        extensions = { "neo-tree", "lazy", "nvim-dap-ui", "quickfix" },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)

      -- override the `showtabline` option to 0 (only display tabline if more than 1 tab)
      -- Reference: https://github.com/nvim-lualine/lualine.nvim/issues/395#issuecomment-1312371694
      vim.cmd("set showtabline=0")
    end,
  },
}
