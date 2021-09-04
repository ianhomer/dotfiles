require("lualine").setup {
    options = {
        sources = {"ale"},
        theme = "gruvbox"
    },
    extensions = {
        "fugitive",
        "fzf",
        "nvim-tree",
        "toggleterm"
    },
    sections = {
        lualine_c = {
            {"filename"},
            {"diff"},
            {
                "diagnostics",
                sources = {"ale", "nvim_lsp"},
                color_error = "white"
            }
        }
    }
}
