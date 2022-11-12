local nvim_tree_events = require("nvim-tree.events")
local bufferline_api = require("bufferline.api")

local function get_tree_size()
  return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
  if vim.o.showtabline > 0 then
    bufferline_api.set_offset(get_tree_size())
  end
end)

nvim_tree_events.subscribe("Resize", function()
  if vim.o.showtabline > 0 then
    bufferline_api.set_offset(get_tree_size())
  end
end)

nvim_tree_events.subscribe("TreeClose", function()
  if vim.o.showtabline > 0 then
    bufferline_api.set_offset(0)
  end
end)

-- Barbar only enabled in mob mode, so disable for now
vim.o.showtabline = 0

local M = {}

local config = {
  animation = false,
  auto_hide = true,
  icon_separator_active = "┃",
  icon_separator_inactive = "┃",
  icon_pinned = "",
  closable = true,
  icon_custom_colors = false,
}

function M.show()
  config.auto_hide = true
  require("bufferline").setup(config)
  if require("nvim-tree.view").is_visible() then
    bufferline_api.set_offset(get_tree_size())
  else
    bufferline_api.set_offset(0)
  end
end

function M.hide()
  config.auto_hide = false
  require("bufferline").setup(config)
end

return M
