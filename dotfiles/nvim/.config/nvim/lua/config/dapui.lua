require("dapui").setup()

vim.api.nvim_set_keymap('n', '<leader>duo', "<cmd>lua require'dapui'.open()<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>duc', "<cmd>lua require'dapui'.close()<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>dut', "<cmd>lua require'dapui'.toggle()<CR>", {})

