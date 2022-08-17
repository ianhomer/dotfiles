local M = {}

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup({
    debug = true,
    sources = {
        -- order is important, prettier should be before eslint
        formatting.prettierd.with({
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/.prettierrc.toml"),
            },
        }),
        formatting.eslint_d,
        formatting.black,
        formatting.fish_indent,
        formatting.stylua,
        diagnostics.markdownlint.with({
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity["HINT"]
            end,
        }),
        diagnostics.eslint_d,
        diagnostics.flake8,
        diagnostics.tidy,
        diagnostics.vale,
        code_actions.eslint_d,
        completion.spell,
    },
})

function M.setLevel(level)
    if level > 4 then
        null_ls.enable("markdownlint")
        null_ls.enable("vale")
    else
        null_ls.disable("markdownlint")
        null_ls.disable("vale")
    end
end

function M.toggle()
    null_ls.toggle("markdownlint")
    null_ls.toggle("vale")
end

return M
