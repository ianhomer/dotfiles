-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

local function isVi(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local action = wezterm.action

-- Thank you https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
local function activatePane(window, pane, pane_direction, vim_direction)
  if isVi(pane) then
    window:perform_action(action.SendKey({ key = vim_direction, mods = "CTRL" }), pane)
  else
    window:perform_action(action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  activatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  activatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  activatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  activatePane(window, pane, "Down", "j")
end)

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local window_background = "#1f1f28"

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font_size = 12.3
config.line_height = 1.15

config.force_reverse_video_cursor = true
config.colors = {
  foreground = "#dcd7ba",
  background = window_background,
  cursor_bg = "#c8c093",
  cursor_fg = "#c8c093",
  cursor_border = "#c8c093",
  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",
  scrollbar_thumb = "#16161d",
  split = "#16161d",
  ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
  brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
  indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  tab_bar = {
    background = window_background,
  },
}
config.tab_max_width = 32

config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {
    key = "-",
    mods = "CMD",
    action = action.SplitVertical,
  },
  {
    key = "\\",
    mods = "CMD",
    action = action.SplitHorizontal,
  },
  {
    key = "t",
    mods = "CMD",
    action = action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "LeftArrow",
    mods = "OPT",
    action = action.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = action.ActivateTabRelative(1),
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = action.EmitEvent("ActivatePaneDirection-right"),
  },
  {
    key = "LeftArrow",
    mods = "CTRL",
    action = action.EmitEvent("ActivatePaneDirection-left"),
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = action.EmitEvent("ActivatePaneDirection-up"),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = action.EmitEvent("ActivatePaneDirection-down"),
  },
  { key = "LeftArrow", mods = "SHIFT|OPT", action = action.MoveTabRelative(-1) },
  { key = "RightArrow", mods = "SHIFT|OPT", action = action.MoveTabRelative(1) },
  { key = "z", mods = "CMD", action = action.TogglePaneZoomState },
  { key = "UpArrow", mods = "SHIFT|CMD", action = action.AdjustPaneSize({ "Up", 5 }) },
  { key = "DownArrow", mods = "SHIFT|CMD", action = action.AdjustPaneSize({ "Down", 5 }) },
  { key = "LeftArrow", mods = "SHIFT|CMD", action = action.AdjustPaneSize({ "Left", 5 }) },
  { key = "RightArrow", mods = "SHIFT|CMD", action = action.AdjustPaneSize({ "Right", 5 }) },
  { key = "UpArrow", mods = "CTRL|CMD", action = action.AdjustPaneSize({ "Up", 1 }) },
  { key = "DownArrow", mods = "CTRL|CMD", action = action.AdjustPaneSize({ "Down", 1 }) },
  { key = "LeftArrow", mods = "CTRL|CMD", action = action.AdjustPaneSize({ "Left", 1 }) },
  { key = "RightArrow", mods = "CTRL|CMD", action = action.AdjustPaneSize({ "Right", 1 }) },

  -- Puzzling, but left opt 3 enters vim mode on terminal.  We can bind it
  -- explicitly to £ to work around this
  {
    key = "3",
    mods = "OPT",
    action = action.SendKey({
      key = "£",
    }),
  },
}

local get_last_folder_segment = function(cwd)
  if cwd == nil then
    return "?"
  end

  local path = {}
  for segment in string.gmatch(cwd, "[^/]+") do
    table.insert(path, segment)
  end
  return path[#path]
end

local function get_relative_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir.file_path or ""
  return get_last_folder_segment(current_dir)
end

local function tab_title(tab)
  if tab.active_pane.current_working_dir.file_path == wezterm.home_dir then
    return "~"
  end
  local relative_working_dir = get_relative_working_dir(tab)
  if relative_working_dir == ".dotfiles" then
    return "."
  elseif relative_working_dir == "things" then
    return "󰧮"
  end
  return relative_working_dir
end

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local active_background = "#2D4F67"
local inactive_background = "#223249"
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = active_background
  local right_edge_background = inactive_background
  local left_edge_foreground = inactive_background
  local foreground = "##DCD7BA"

  if not tab.is_active then
    background = inactive_background
    foreground = "#727169"
    right_edge_background = active_background
    left_edge_foreground = active_background
    if tab.tab_index < #tabs - 1 then
      if not tabs[tab.tab_index + 2].is_active then
        right_edge_background = inactive_background
      end
    end
  end

  if tab.tab_index == #tabs - 1 then
    right_edge_background = window_background
  end

  local function title_explicit_or_dynamic()
    local explicit_title = tab.tab_title
    if explicit_title and #explicit_title > 0 then
      return explicit_title
    end
    return wezterm.truncate_left(" " .. tab_title(tab) .. " ", max_width + 2)
  end

  local title = title_explicit_or_dynamic()

  return {
    { Background = { Color = background } },
    { Foreground = { Color = left_edge_foreground } },
    { Text = "" },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = right_edge_background } },
    { Foreground = { Color = background } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

wezterm.on("gui-startup", function(_)
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
  local _, second_pane, _ = window:spawn_tab({ cwd = wezterm.home_dir .. "/.dotfiles" })
  local _, third_pane, _ = window:spawn_tab({ cwd = wezterm.home_dir .. "/projects/things" })
  window:spawn_tab({ cwd = wezterm.home_dir .. "/projects" })

  second_pane:send_text("vi\n")
  third_pane:send_text("vi\n")
end)

return config
