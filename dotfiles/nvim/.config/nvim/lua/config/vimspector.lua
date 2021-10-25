vim.g.vimspector_enable_mappings = 'HUMAN'

vim.api.nvim_set_keymap('n', '<leader>vl', "call vimspector#Launch()<CR>", {})

