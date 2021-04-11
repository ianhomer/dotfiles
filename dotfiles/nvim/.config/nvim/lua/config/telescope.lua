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
vim.api.nvim_set_keymap("n", " t", [[<Cmd>Telescope<CR>]], opt)
