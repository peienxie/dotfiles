local wezterm = require("wezterm")

local M = {}

M.setup = function(config)
  local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

  resurrect.state_manager.periodic_save({
    interval_seconds = 15 * 60,
    save_workspaces = true,
    save_windows = true,
    save_tabs = true,
  })

  -- Load the state whenever I create a new workspace
  wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, _, label)
    local workspace_state = resurrect.workspace_state

    workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
      window = window,
      relative = true,
      restore_text = true,
      on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
  end)

  -- Save the state whenever I select a workspace
  wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(_, _, _)
    local workspace_state = resurrect.workspace_state
    resurrect.state_manager.save_state(workspace_state.get_workspace_state())
  end)

  wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)
end

return M
