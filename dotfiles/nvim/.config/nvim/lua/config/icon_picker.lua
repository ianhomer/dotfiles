require("icon-picker").setup({
    disable_legacy_commands = true,
})

local opts = { noremap = true, silent = true }

vim.keymap.set("i", "<C-k><C-k>", "<cmd>IconPickerInsert emoji<cr>", opts)
vim.keymap.set("i", "<C-k><C-o>", "<cmd>IconPickerInsert<cr>", opts)
