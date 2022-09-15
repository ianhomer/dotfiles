local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.init_lsp_saga({ })

local opts = { silent = true }

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
