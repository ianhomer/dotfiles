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

local colors = require("kanagawa.colors").setup()

vim.cmd("hi TelescopeBorder guibg = " .. colors.bg_dim .. " guifg = " .. colors.bg_dim)

vim.cmd("hi TelescopePromptBorder guibg = " .. colors.bg_light1 .. " guifg = " .. colors.bg_light1)
vim.cmd("hi TelescopePromptNormal guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)
vim.cmd("hi TelescopePromptPrefix guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)
vim.cmd("hi TelescopeSelection guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)

vim.cmd("hi TelescopePreviewTitle guibg = " .. colors.bg_dim .. " guifg = " .. colors.co)
vim.cmd("hi TelescopePromptTitle guibg = " .. colors.bg_light1 .. " guifg = " .. colors.co)
vim.cmd("hi TelescopeResultsTitle guibg = " .. colors.bg_dim .. " guifg = " .. colors.co)

local opt = { noremap = true, silent = true }
