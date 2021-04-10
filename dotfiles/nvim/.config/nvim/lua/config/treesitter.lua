local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
    ensure_installed = {
        "bash",
        "css",
        "java",
        "json",
        "html",
        "lua",
        "python",
        "javascript",
        "scss",
        "tsx",
        "typescript",
        "yaml",
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
