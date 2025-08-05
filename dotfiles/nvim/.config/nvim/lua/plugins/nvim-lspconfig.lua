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
            useFlatConfig = nil, -- option not in the latest eslint-lsp
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" or client.name == "vtsls" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
