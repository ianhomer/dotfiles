-- terminal specific window navigator
if vim.g.knob_kitty then
  return require("config.kitty")
elseif vim.g.knob_wezterm then
  return require("config.wezterm")
end

