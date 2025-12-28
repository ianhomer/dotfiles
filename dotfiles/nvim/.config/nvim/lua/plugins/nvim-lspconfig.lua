return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      -- See https://github.com/LazyVim/LazyVim/issues/3383
      eslint = {
        settings = {
          useFlatConfig = false, -- set if using flat config
          experimental = {
            useFlatConfig = nil, -- Option not in the latest eslint-lsp
          },
        },
      },
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            linters = {
              SpellCheck = true,
              SentenceCapitalization = true,
            },
            dialect = "British",
            diagnosticSeverity = "hint",
          },
        },
      },
    },
    setup = {
      -- nvim > v0.11 needed for workspace_diagnostics
      -- ["*"] = function()
      --   vim.lsp.buf.workspace_diagnostics()
      -- end,
    },
  },
}
