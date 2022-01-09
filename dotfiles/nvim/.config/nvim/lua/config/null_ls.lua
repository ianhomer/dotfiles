local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.completion.spell,
    },
})
