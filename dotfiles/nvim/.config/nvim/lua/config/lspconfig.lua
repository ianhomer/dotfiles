local lspconfig = require("lspconfig")

-- get next and previous diagnostic functions
local next_diagnostic, prev_diagnostic = (function()
  if vim.g.knob_treesitter_textobjects then
    -- if we have treesitter text objects installed we can return a repeatable
    -- function allowing ';' and ',' to repeat forward and backward
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    return ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
  else
    return vim.diagnostic.goto_next, vim.diagnostic.goto_prev
  end
end)()

local outer_nmap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, noremap = true, desc = desc })
end
outer_nmap("[d", prev_diagnostic, "Previous diagnostic")
outer_nmap("]d", next_diagnostic, "Next diagnostic")

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=grey guibg=#1f2335]])

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, _opts, ...)
  local opts = _opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  if not vim.g.knob_lspsaga then
    nmap("K", vim.lsp.buf.hover, "Hover")
    nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
  end
  nmap("gr", vim.lsp.buf.references, "Go to references")
  nmap("gd", vim.lsp.buf.definition, "Go to definition")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
  nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
  -- C-k conflicts with tmux split navigation
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  nmap("<leader>,sh", vim.lsp.buf.signature_help, "Signature help")

  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  nmap("<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspaces")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type definition")

  if vim.g.knob_none_ls then
    -- Only use none_ls for formatting by disabling the lsp document formatting
    -- providers. When we want to more subtle and use a balance of none_ls and
    -- LSP formatting we can tweak this along with appropriate use of vim.lsp.buf.format
    -- See https://github.com/nvimtools/none-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
              hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateGray
              hi LspReferenceText cterm=bold ctermbg=red guibg=DarkSlateGray
              hi LspReferenceWrite cterm=bold ctermbg=red guibg=DarkSlateGray
              hi LspDiagnosticsDefaultHint ctermbg=grey guifg=Grey30 guibg=DarkSlateGray
              hi DiagnosticError guifg=White

            ]],
      false
    )
    -- augroup lsp_document_highlight
    --   autocmd! * <buffer>
    --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    -- augroup END
  end

  -- vim.api.nvim_create_autocmd("CursorHold", {
  --     buffer = bufnr,
  --     callback = function()
  --         vim.diagnostic.open_float(nil, {
  --             focusable = false,
  --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --             border = "rounded",
  --             source = "always",
  --             prefix = " ",
  --             scope = "cursor",
  --         })
  --     end,
  -- })

  vim.diagnostic.config({
    float = {
      source = "yes",
    },
  })
  -- require"lsp_signature".on_attach()
end

-- for now stick with the native vim format expr. In the future I may like the
-- LSP formatexpr registration.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
-- https://zignar.net/2022/10/01/new-lsp-features-in-neovim-08/
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  bashls = {},
  cssls = {
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
  html = {},
  jsonls = {
    init_options = {
      jsonls = {
        provideFormatter = false,
      },
    },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        format = false,
      },
    },
  },
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         rope_autoimport = {
  --           enabled = true,
  --           memory = false
  --         },
  --         rope_completion = {
  --           enabled = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  pyright = {
    -- see setting documentation in https://github.com/microsoft/pyright/blob/main/packages/vscode-pyright/package.json
    settings = {
      pyright = {
        disableOrganizeImports = false,
        disableLanguageServices = false,
      },
      python = {
        analysis = {
          autoImportCompletions = true,
          -- logLevel = "Trace",
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        runtime = {
          version = "LuaJIT",
        },
        telemetry = { enable = false },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  },
  svelte = { "svelte" },
  tailwindcss = {
    filetypes = { "css" },
  },
  terraformls = {
    filetypes = { "terraform", "hcl" },
  },
  tsserver = {},
  vimls = {},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
for server, opts in pairs(servers) do
  local module = lspconfig[server]
  if module then
    -- experimental ufo folding configuration
    -- capabilities.textDocument.foldingRange = {
    --     dynamicRegistration = false,
    --     lineFoldingOnly = true
    -- }
    opts.capabilities = capabilities
    opts.on_attach = on_attach
    module.setup(opts)
  else
    print("Can't set up LSP for" .. server)
  end
end
