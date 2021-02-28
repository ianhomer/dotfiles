local cmd = vim.cmd

cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
local o = vim.o

o["runtimepath"] = o["runtimepath"] .. ",~/.vim"

local knobs = require("knobs")

cmd 'call knobs#Init()'

paq {'savq/paq-nvim', opt = true}

knobs.paq('gruvbox', 'morhetz/gruvbox')
knobs.paq('gruvbox8', 'lifepillar/vim-gruvbox8')

knobs.paq('fzf', 'junegunn/fzf')
knobs.paq('fzf', 'junegunn/fzf.vim')
knobs.paq('fugitive', 'tpope/vim-fugitive')
knobs.paq('fugitive', 'tpope/vim-rhubarb')
knobs.paq('gitgutter', 'airblade/vim-gitgutter')
knobs.paq('dispatch', 'tpope/vim-dispatch')
knobs.paq('nerdtree', 'preservim/nerdtree')
knobs.paq('startify', 'mhinz/vim-startify')

knobs.paq('airline', 'vim-airline/vim-airline')
knobs.paq('airline', 'vim-airline/vim-airline-themes')
knobs.paq('gutentags', 'ludovicchabant/vim-gutentags')
knobs.paq('tabular', 'godlygeek/tabular')

paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'nvim-lua/diagnostic-nvim'
knobs.paq('startuptime', 'tweekmonster/startuptime.vim')

knobs.paq('nerdtree', 'ryanoasis/vim-devicons')
knobs.paq('minimap', 'wfxr/minimap.vim')

knobs.paq('ale', 'dense-analysis/ale')

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=Grey
      hi LspReferenceText cterm=bold ctermbg=red guibg=Grey
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=Grey
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "bashls", "cssls", "jsonls", "pyls", "tsserver", "vimls",  }
for _, lsp in ipairs(servers) do
  local lspserver = lspconfig[lsp]
  if lspserver then
    lspconfig[lsp].setup { on_attach = on_attach }
  else
    print("Can't set up LSP for"..lsp)
  end
end

--  let g:completion_chain_complete_list = {
--    \ 'default': [
--    \    {'complete_items': ['lsp', 'snippet' ]},
--    \    {'mode': '<c-p>'},
--    \    {'mode': '<c-n>'}
--    \]
--  \}
--  imap <c-p> <Plug>(completion_trigger)
--
--  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
--  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
--  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
--  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
--  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
--  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
--  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>


