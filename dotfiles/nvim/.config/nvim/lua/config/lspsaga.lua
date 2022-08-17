local saga = require("lspsaga")

saga.init_lsp_saga({})

local opts = { silent = true }

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
