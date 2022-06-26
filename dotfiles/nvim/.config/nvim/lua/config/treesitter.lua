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
