require("refactoring").setup({})

local opt = { noremap = true, silent = true, expr = false }

vim.keymap.set("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opt)
vim.keymap.set(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)
vim.keymap.set(
    "n",
    "<leader>rv",
    ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
    { noremap = true }
)
vim.keymap.set("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
vim.keymap.set("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
