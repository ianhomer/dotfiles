require("nvim-tree").setup({
    create_in_closed_folder = true,
    hijack_cursor = true,
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
        full_name = true,
        group_empty = true,
        special_files = {},
        highlight_opened_files = "all",
        highlight_git = true,
        icons = {
            git_placement = "after",
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
    live_filter = {
      always_show_folders = false
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
