require("icon-picker").setup({
    disable_legacy_commands = true,
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>I", "<cmd>IconPickerNormal<cr>", opts)
vim.keymap.set("i", "<C-l>", "<cmd>IconPickerInsert<cr>", opts)
