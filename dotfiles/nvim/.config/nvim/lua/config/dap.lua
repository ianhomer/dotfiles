local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/projects/opensource/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
dap.configurations.typescript = dap.configurations.javascript

vim.api.nvim_set_keymap('n', ',c', "<cmd>lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap('n', ',t', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap('n', ',v', "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", {})
vim.api.nvim_set_keymap('n', ',r', "<cmd>lua require'dap'.repl.open()<CR>", {})
vim.api.nvim_set_keymap('n', ',d', "<cmd>Telescope dap commands<CR>", {})

-- vim.api.nvim_set_keymap('n', '<leader>df', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {})
