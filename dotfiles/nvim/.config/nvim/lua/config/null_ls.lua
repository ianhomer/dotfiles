local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.completion.spell,
    },
})
