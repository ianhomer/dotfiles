local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

require("codewindow").setup({
    auto_enable = false,
    exclude_filetypes = { "NvimTree", "fugitive", "help", "startify", "Trouble" },
    max_minimap_height = 45,
    width_multiplier = 8,
    minimap_width = 10,
    show_cursor = false,
    window_border = border,
})
