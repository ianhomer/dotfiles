local M = {}

local none_ls = require("null-ls")
local none_ls_legacy = require("config/none_ls_legacy")
local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics
local code_actions = none_ls.builtins.code_actions
local completion = none_ls.builtins.completion

none_ls.setup({
  debug = false,
  sources = {
    -- order is important, prettier should be before eslint
    formatting.prettierd.with({
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/.prettierrc.toml"),
      },
    }),
    none_ls_legacy.formatting.eslint_d,
    formatting.black,
    formatting.fish_indent,
    none_ls_legacy.formatting.rustfmt,
    formatting.stylua,
    none_ls_legacy.formatting.trim_whitespace.with({
      filetypes = { "cucumber", "sh" },
    }),
    diagnostics.markdownlint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["HINT"]
      end,
    }),
    none_ls_legacy.diagnostics.eslint_d,
    none_ls_legacy.diagnostics.flake8.with({
      args = {
        "--format",
        "default",
        "--stdin-display-name",
        "$FILENAME",
        "-",
        "--config",
        vim.fn.expand("~/.flake8"),
      },
    }),
    diagnostics.mypy,
    diagnostics.tidy,
    diagnostics.vale,
    diagnostics.trail_space.with({
      filetypes = { "cucumber" },
    }),
    diagnostics.yamllint,
    none_ls_legacy.code_actions.eslint_d,
    completion.spell.with({
      filetypes = { "markdown" },
    }),
  },
})

function M.setLevel(level)
  if level > 4 then
    none_ls.enable("markdownlint")
    none_ls.enable("vale")
  else
    none_ls.disable("markdownlint")
    none_ls.disable("vale")
  end
end

function M.toggle()
  none_ls.toggle("markdownlint")
  none_ls.toggle("vale")
end

return M
