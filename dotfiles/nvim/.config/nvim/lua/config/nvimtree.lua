vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_window_picker_exclude = {
    filetype = {},
    buftype = {
        "terminal",
        "nofile",
    },
}

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
}

vim.g.nvim_tree_icons = {
    default = "",
}
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_highlight_opened_files = 2

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        icons = {
            hint = ".",
            info = "~",
            warning = "!",
            error = "!",
        },
    },
    update_focused_file = {
        enable = true,
    },
    filters = {
        dotfiles = true,
        custom = { ".DS_Store", ".git", ".pytest_cache", "node_modules" },
        exclude = { ".env", ".config" }
    },
})

vim.api.nvim_exec([[
augroup nvimttree
    au!
    au BufLeave NvimTree NvimTreeRefresh
    au BufEnter NvimTree NvimTreeRefresh
augroup END
]], false)
