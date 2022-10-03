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

require("bufferline").setup({
    animation = false,
    auto_hide = false,
    icon_pinned = "",
    closable = true,
    icon_custom_colors = true,
})

-- Barbar only enabled in mob mode, so disable for now
vim.o.showtabline=0


