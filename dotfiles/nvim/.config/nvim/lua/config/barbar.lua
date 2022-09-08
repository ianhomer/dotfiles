local nvim_tree_events = require("nvim-tree.events")
local bufferline_state = require("bufferline.state")

local function get_tree_size()
    return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
    if vim.o.showtabline > 0 then
        bufferline_state.set_offset(get_tree_size())
    end
end)

nvim_tree_events.subscribe("Resize", function()
    if vim.o.showtabline > 0 then
        bufferline_state.set_offset(get_tree_size())
    end
end)

nvim_tree_events.subscribe("TreeClose", function()
    if vim.o.showtabline > 0 then
        bufferline_state.set_offset(0)
    end
end)

require("bufferline").setup({
    animation = true,
    auto_hide = false,
    icon_pinned = "",
    closable = true,
    icon_custom_colors = true,
})

-- Barbar only enabled in mob mode, so disable for now
vim.o.showtabline=0
