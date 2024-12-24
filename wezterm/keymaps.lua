local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.setup = function(config)
  config.disable_default_key_bindings = true

  -- keymaps
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
  config.keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    { key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
    { key = "p", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },
    { key = "r", mods = "LEADER|SHIFT", action = act.ReloadConfiguration },
    { key = "l", mods = "LEADER|SHIFT", action = act.ShowDebugOverlay },
    { key = "u", mods = "LEADER|SHIFT", action = act.CharSelect },

    -- clipboard
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "]", mods = "LEADER", action = act.QuickSelect },
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
    { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
    { key = "f", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },

    -- fontsize
    { key = "+", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
    { key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
    { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
    { key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },

    -- Pane keybindings
    { key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = '"', mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Right") },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "}", mods = "LEADER|SHIFT", action = act.RotatePanes("Clockwise") },
    { key = "{", mods = "LEADER|SHIFT", action = act.RotatePanes("CounterClockwise") },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    {
      key = "r",
      mods = "LEADER|CTRL",
      action = act.ActivateKeyTable({
        name = "RESIZE",
        until_unknown = true,
        timeout_milliseconds = 1000,
        one_shot = false,
      }),
    },

    -- Tab keybindings
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "C", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "DOMAINS" }) },
    -- navigating tabs
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "LEADER", action = act.ActivateLastTab },
    { key = ">", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
    { key = "<", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
    { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = act.ActivateTab(8) },
    { key = "0", mods = "LEADER", action = act.ActivateTab(9) },
    {
      key = "t",
      mods = "LEADER",
      action = act.ActivateKeyTable({
        name = "TAB",
        until_unknown = true,
        timeout_milliseconds = 1000,
        one_shot = false,
      }),
    },
    -- renaming tab
    {
      key = ",",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "New tab name",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    },

    -- listing workspaces
    { key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    {
      key = "$",
      mods = "LEADER|SHIFT",
      action = act.PromptInputLine({
        description = "New workspace name",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      }),
    },
    { key = ")", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
    { key = "(", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
  }

  config.key_tables = {
    ["RESIZE"] = {
      { key = "h", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "j", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "k", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "l", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "h", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
      { key = "j", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
      { key = "k", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
      { key = "l", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
      { key = "q", action = "PopKeyTable" },
      { key = "Escape", action = "PopKeyTable" },
      { key = "Enter", action = "PopKeyTable" },
    },
    ["TAB"] = {
      { key = "n", action = act.ActivateTabRelative(1) },
      { key = "p", action = act.ActivateTabRelative(-1) },
      { key = ">", mods = "SHIFT", action = act.MoveTabRelative(1) },
      { key = "<", mods = "SHIFT", action = act.MoveTabRelative(-1) },
      --{ key = "h", action = act.MoveTabRelative(-1) },
      --{ key = "j", action = act.MoveTabRelative(1) },
      --{ key = "k", action = act.MoveTabRelative(-1) },
      --{ key = "l", action = act.MoveTabRelative(1) },
      { key = "q", action = "PopKeyTable" },
      { key = "Escape", action = "PopKeyTable" },
      { key = "Enter", action = "PopKeyTable" },
    },
  }
end

return M
