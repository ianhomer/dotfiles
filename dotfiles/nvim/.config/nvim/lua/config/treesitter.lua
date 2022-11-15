local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
    ensure_installed = {
        "bash",
        "css",
        "go",
        "hcl",
        "java",
        "json",
        "html",
        "lua",
        "make",
        "markdown",
        "python",
        "javascript",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
    indent = {
      enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>'
        }
    }
}

-- fix attempt to index local 'node_or_range' for cmd window
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/2634
vim.api.nvim_create_augroup("cmdwin_treesitter", { clear = true })
vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "*",
  command = "TSBufDisable incremental_selection",
  group = "cmdwin_treesitter",
  desc = "Disable treesitter's incremental selection in Command-line window",
})
