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

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font_size = 12.5

config.force_reverse_video_cursor = true
config.colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",
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
        background = "#1F1F28",
    },
}

config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

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
        action = action.EmitEvent("ActivatePaneDirection-left"),
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
}

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local active_background = "#2D4F67"
local inactive_background = "#223249"

wezterm.on("format-tab-title", function(tab, tabs, panes, _config, hover, max_width)
    local background = inactive_background
    local right_edge_background = active_background
    local left_edge_foreground = active_background
    local foreground = "#727169"

    if tab.is_active then
        background = active_background
        right_edge_background = inactive_background
        left_edge_foreground = inactive_background
        foreground = "##DCD7BA"
    elseif hover then
        background = "#3b3052"
        foreground = "#909090"
    end

    local title = wezterm.truncate_right(tab_title(tab), max_width - 2)

    return {
        { Background = { Color = background } },
        { Foreground = { Color = left_edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = right_edge_background } },
        { Foreground = { Color = background } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

return config
