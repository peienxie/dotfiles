local wezterm = require("wezterm")

local M = {}

local function getHome()
  return os.getenv("HOME") or string.gsub(os.getenv("USERPROFILE") or "", "\\", "/")
end

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "C:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function remove_trailing_slash(s)
  return string.gsub(s, "[/]$", "")
end

local function decode_URI(uri)
  return string.gsub(uri, "%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
end

local function get_current_working_dir(tab)
  local cwd_uri = tab.active_pane.current_working_dir

  local cwd
  if cwd_uri and type(cwd_uri) == "userdata" then
    cwd = cwd_uri.file_path
  elseif cwd_uri then
    -- replace "file://{host}/" with /
    cwd_uri = decode_URI(tostring(cwd_uri))
    cwd = string.gsub(cwd_uri, "(^file://.*?)[/]", "/")
  else
    cwd = "?"
  end

  -- the dir has a trailing slash on Windows
  cwd = remove_trailing_slash(cwd)
  cwd = string.gsub(cwd, getHome(), "~")
  return basename(cwd)
end

M.setup = function(config)
  config.tab_max_width = 50
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.switch_to_last_active_tab_when_closing_tab = true
  config.show_new_tab_button_in_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = false

  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local icon
    if tab.active_pane.is_zoomed then
      icon = "🔎"
    else
      icon = ""
    end

    local title
    if tab.tab_title and #tab.tab_title > 0 then
      title = tab.tab_title
    else
      title = get_current_working_dir(tab)
    end

    return {
      { Text = string.format(" %s%d:%s ", icon, tab.tab_index + 1, title) },
    }
  end)

  wezterm.on("update-status", function(window, pane)
    local colors = {
      fg = (window:leader_is_active() or window:active_key_table()) and "#111111" or "#eeeeee",
      bg = (window:leader_is_active() or window:active_key_table()) and "#b9cc52" or "#4b2a92",
    }
    local status_text = window:active_key_table() or window:active_workspace()
    window:set_left_status(wezterm.format({
      { Foreground = { Color = colors.fg } },
      { Background = { Color = colors.bg } },
      { Text = "  " .. status_text .. " " },
    }))
    local datetime_text = wezterm.strftime("%a %m/%d %H:%M:%S")
    window:set_right_status(wezterm.format({
      { Foreground = { Color = colors.fg } },
      { Background = { Color = colors.bg } },
      { Text = "  " .. datetime_text .. " " },
    }))
  end)
end

return M
