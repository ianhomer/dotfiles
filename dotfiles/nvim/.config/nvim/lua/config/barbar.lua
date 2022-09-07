local opt = { noremap = true, silent = false }
vim.api.nvim_set_keymap("n", "≤", [[<Cmd>:BufferPrevious<CR>]], opt)
vim.api.nvim_set_keymap("n", "≥", [[<Cmd>:BufferNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "¯", [[<Cmd>:BufferMovePrevious<CR>]], opt)
vim.api.nvim_set_keymap("n", "˘", [[<Cmd>:BufferMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "÷", [[<Cmd>:BufferPin<CR>]], opt)

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)

require'bufferline'.setup {
  animation = true,
  auto_hide = false,
  icon_pinned = "",
  closable = true,
  icon_custom_colors = true
}
