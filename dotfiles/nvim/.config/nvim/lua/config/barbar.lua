local opt = {noremap = true, silent = false}
vim.api.nvim_set_keymap("n", "≤", [[<Cmd>:BufferPrevious<CR>]], opt)
vim.api.nvim_set_keymap("n", "≥", [[<Cmd>:BufferNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "¯", [[<Cmd>:BufferMovePrevious<CR>]], opt)
vim.api.nvim_set_keymap("n", "˘", [[<Cmd>:BufferMoveNext<CR>]], opt)
vim.api.nvim_set_keymap("n", "÷", [[<Cmd>:BufferPin<CR>]], opt)

vim.g.bufferline = {
    auto_hide = true
}
