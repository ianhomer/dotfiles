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
    git = {
        ignore = false,
    },
    filters = {
        dotfiles = true,
        custom = { "^\\.DS_Store", "^\\.git$", "^\\.pytest_cache", "^node_modules" },
        exclude = { ".env", ".config" },
    },
    renderer = {
        special_files = {},
        highlight_opened_files = "icon",
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = false,
            },
            glyphs = {
                default = "",
            },
        },
    },
    actions = {
        open_file = {
            window_picker = {
                enable = true,
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = {
                        "terminal",
                        "nofile",
                        "Help",
                    },
                },
            },
        },
    },
})

vim.api.nvim_exec(
    [[
augroup nvimttree
    au!
    au BufLeave NvimTree NvimTreeRefresh
    au BufEnter NvimTree NvimTreeRefresh
augroup END
]],
    false
)
