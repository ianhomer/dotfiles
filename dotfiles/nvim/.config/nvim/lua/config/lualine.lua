require("lualine").setup {
    options = {
        sources = {"ale"},
        theme = "gruvbox"
    },
    sections = {
        lualine_c = {
            {"filename"},
            {"diff"},
            {
                "diagnostics",
                sources = {"ale", "nvim_lsp"},
                color_error = "#ffffff"
            }
        }
    }
}
