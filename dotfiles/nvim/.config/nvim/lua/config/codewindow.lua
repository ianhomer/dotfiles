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
    auto_enable = true,
    exclude_filetypes = { "NvimTree", "fugitive", "help", "startify" },
    max_minimap_height = 20,
    width_multiplier = 8,
    minimap_width = 10,
    window_border = border,
})
