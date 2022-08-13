local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

local git_command = {
    "git",
    "log",
    "--date=format:%Y-%m-%d %H:%M",
    "--format=%h %cd %<(8,trunc)%aN %s",
    "--abbrev-commit",
    "--",
    ".",
}

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
            "--hidden",
            "--ignore-file",
            os.getenv("HOME") .. "/.config/rg/nvim-telescope.ignore",
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
    extensions = {
        frecency = {
            default_workspace = "CWD",
            show_scores = true,
        },
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
        git_bcommits = {
            git_command = git_command,
        },
        git_commits = {
            git_command = git_command,
        },
    },
})
telescope.load_extension("fzf")
if vim.g.knob_frecency then
    telescope.load_extension("frecency")
end

if vim.g.knob_refactoring then
    telescope.load_extension("refactoring")
end

local colors = require("kanagawa.colors").setup()

vim.cmd("hi TelescopeBorder guibg = " .. colors.bg_dim .. " guifg = " .. colors.bg_dim)

vim.cmd("hi TelescopePromptBorder guibg = " .. colors.bg_light1 .. " guifg = " .. colors.bg_light1)
vim.cmd("hi TelescopePromptNormal guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)
vim.cmd("hi TelescopePromptPrefix guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)
vim.cmd("hi TelescopeSelection guibg = " .. colors.bg_light1 .. " guifg = " .. colors.nu)

vim.cmd("hi TelescopePreviewTitle guibg = " .. colors.bg_dim .. " guifg = " .. colors.co)
vim.cmd("hi TelescopePromptTitle guibg = " .. colors.bg_light1 .. " guifg = " .. colors.co)
vim.cmd("hi TelescopeResultsTitle guibg = " .. colors.bg_dim .. " guifg = " .. colors.co)

-- Disable which-key registry help in TelescopePrompt so that C-R can be used to
-- insert from registry
-- https://github.com/nvim-telescope/telescope.nvim/issues/1047
vim.api.nvim_exec(
    [[
    augroup telescope
        autocmd!
        autocmd FileType TelescopePrompt inoremap <buffer> <silent> <C-r> <C-r>
    augroup END]],
    false
)
