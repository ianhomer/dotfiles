-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 13.0

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
}

config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.tab_bar_at_bottom = true

local action = wezterm.action
config.keys = {
    {
        key = "-",
        mods = "CMD",
        action = action.SplitVertical,
    },
    {
        key = "/",
        mods = "CMD",
        action = action.SplitHorizontal,
    },
    {
        key = "t",
        mods = "CMD",
        action = action.SpawnTab "CurrentPaneDomain",
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
        action = action.ActivatePaneDirection("Right"),
    },
    {
        key = "LeftArrow",
        mods = "CTRL",
        action = action.ActivatePaneDirection("Left"),
    },
    {
        key = "RightArrow",
        mods = "CTRL",
        action = action.ActivatePaneDirection("Right"),
    },
    {
        key = "UpArrow",
        mods = "CTRL",
        action = action.ActivatePaneDirection("Up"),
    },
    {
        key = "DownArrow",
        mods = "CTRL",
        action = action.ActivatePaneDirection("Down"),
    },
}

-- pane:split { args = { 'top' } }

-- and finally, return the configuration to wezterm
return config
