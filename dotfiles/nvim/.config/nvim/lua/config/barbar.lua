local has_nvim_tree_view, nvim_tree_view = pcall(require, "nvim-tree.view")

local function get_tree_size()
  if has_nvim_tree_view then
    return nvim_tree_view.View.width
  else
    return 0
  end
end

local has_bufferline, bufferline = pcall(require, "bufferline")
local has_nvim_tree_api, nvim_tree_api = pcall(require, "nvim-tree.api")
local has_bufferline_api, bufferline_api = pcall(require, "bufferline.api")

if has_bufferline_api and has_nvim_tree_api then
  nvim_tree_api.events.subscribe("TreeOpen", function()
    if vim.o.showtabline > 0 then
      bufferline_api.set_offset(get_tree_size())
    end
  end)

  nvim_tree_api.events.subscribe("Resize", function(size)
    if vim.o.showtabline > 0 then
      bufferline_api.set_offset(size)
    end
  end)

  nvim_tree_api.events.subscribe("TreeClose", function()
    if vim.o.showtabline > 0 then
      bufferline_api.set_offset(0)
    end
  end)
end

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
  if has_bufferline then
    bufferline.setup(config)
    if has_nvim_tree_view and nvim_tree_view.is_visible() then
      bufferline_api.set_offset(get_tree_size())
    else
      bufferline_api.set_offset(0)
    end
  end
end

function M.hide()
  config.auto_hide = false
  require("bufferline").setup(config)
end

return M
