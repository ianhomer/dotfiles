"
" Test with
"
" nvim -u test/vim/completion-rc.vim test/vim/completion-rc.vim
" nvim -u test/vim/completion-rc.vim test/scratch.ts
"
" If completion not showing up with you type in insert mode then
" check which scripts are loaded with :scriptnames
"
" verbose set omnifunc?

set runtimepath^=~/.vim-slim
set runtimepath-=~/.config/nvim/after
set runtimepath-=~/.config/nvim
let &packpath = &runtimepath
call plug#begin('~/.config/nvim/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
call plug#end()

lua require'lspconfig'.tsserver.setup{
            \   cmd = { "typescript-language-server", "--stdio","--log-level","4" },
            \   on_attach=require'completion'.on_attach
            \ }
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

set omnifunc=v:lua.vim.lsp.omnifunc


