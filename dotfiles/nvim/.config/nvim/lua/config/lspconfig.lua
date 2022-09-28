local lspconfig = require("lspconfig")
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    if not vim.g.knob_lspsaga then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    end
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    -- C-k conflicts with tmux split navigation
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set("n", "<leader>,sh", vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)

    if vim.g.knob_null_ls then
        -- Use null-ls for formatting
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
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

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            })
        end,
    })

    vim.diagnostic.config({
        float = {
            source = "yes",
        },
    })

    -- require"lsp_signature".on_attach()
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tailwindcss",
    "terraformls",
    "tsserver",
    "vimls",
}
local lspsettings = {
    sumneko_lua = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    cssls = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
    jsonls = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
}

local filetypes = {
    terraformls = { "terraform", "hcl" },
}
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
    local module = lspconfig[lsp]
    if module then
        -- experimental ufo folding configuration
        -- capabilities.textDocument.foldingRange = {
        --     dynamicRegistration = false,
        --     lineFoldingOnly = true
        -- }
        module.setup({
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            filetypes = filetypes[lsp],
            settings = lspsettings[lsp],
            capabilities = capabilities,
        })
    else
        print("Can't set up LSP for" .. lsp)
    end
end
