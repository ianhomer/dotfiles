require("icon-picker").setup({
    disable_legacy_commands = true,
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>I", "<cmd>IconPickerNormal emoji<cr>", opts)
vim.keymap.set("i", "<C-l>", "<cmd>IconPickerInsert emoji<cr>", opts)
