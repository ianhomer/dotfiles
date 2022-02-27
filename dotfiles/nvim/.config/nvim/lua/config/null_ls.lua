local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = true,
    sources = {
        formatting.black,
        formatting.eslint_d,
        formatting.fish_indent,
        formatting.stylua,
        formatting.prettierd,
        formatting.markdownlint,
        diagnostics.eslint_d,
        diagnostics.flake8,
        diagnostics.proselint,
        diagnostics.write_good,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.completion.spell,
    },
})
