return {
  {
    "mfussenegger/nvim-dap",
    keys = function()
      -- stylua: ignore
      return {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        -- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

        { "<F6>", function() require("dap").step_back() end, desc = "Step Back" },
        { "<F7>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<F8>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<F9>", function() require("dap").step_out() end, desc = "Step Out" },
        { "<F10>", function() require("dap").continue() end, desc = "Continue" },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      -- stylua: ignore
      { "<leader>dE", function() require("dapui").eval(vim.fn.input("Expression > ")) end, desc = "Eval Input", mode = {"n", "v"} },
    },
    opts = {
      layouts = {
        {
          elements = {
            "scopes",
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      controls = { enabled = false },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      -- Automatically open DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ reset = true })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = false,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    config = function()
      -- stylua: ignore
      vim.keymap.set("n", "<leader>dam", function() require("dap-go").debug_test() end, { desc = "Debug Method", buffer = 0 })
      require("dap-go").setup()
    end,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "delve")
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      -- stylua: ignore
      vim.keymap.set("n", "<leader>dam", function() require("dap-python").test_method() end, { desc = "Debug Method", buffer = 0 })
      -- stylua: ignore
      vim.keymap.set("n", "<leader>dac", function() require("dap-python").test_class() end, { desc = "Debug Class", buffer = 0 })

      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "debugpy")
        end,
      },
    },
  },
}
