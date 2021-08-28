require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        }
    }
}

local opt = {noremap = true, silent = true}
-- core
--vim.api.nvim_set_keymap("n", " f", [[<Cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>]], opt)

-- extras
vim.api.nvim_set_keymap("n", " tt", [[<Cmd>Telescope<CR>]], opt)
vim.api.nvim_set_keymap("n", " tb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", " tf", [[<Cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>]], opt)
vim.api.nvim_set_keymap("n", " th", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
