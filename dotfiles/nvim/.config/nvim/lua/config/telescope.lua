local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--glob",
            "!**/.git/**",
            "--hidden",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
        --    i = {["<c-t>"] = trouble.open_with_trouble},
        --    n = {["<c-t>"] = trouble.open_with_trouble}
        --},
        path_display = { "shorten" },
        layout_strategy = "vertical",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
            },
            vertical = {
              mirror = false,
            },
            height = 0.95,
            width = 0.95,
        },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-k>"] = "delete_buffer",
                },
            },
        },
    },
})
telescope.load_extension("fzf")

local opt = { noremap = true, silent = true }
