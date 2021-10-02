local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/projects/opensource/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}
dap.configurations.typescript = dap.configurations.javascript

vim.api.nvim_set_keymap('n', '<leader>dc', "<cmd>lua require'dap'.continue()<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>dv', "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>dr', "<cmd>lua require'dap'.repl.open()<CR>", {})
vim.api.nvim_set_keymap('n', '<leader>df', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", {})
