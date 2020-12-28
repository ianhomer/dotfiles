"
" Test with
"
" nvim -u test/vim/completion-rc.vim test/vim/completion-rc.vim
" nvim -u test/vim/completion-rc.vim test/scratch.ts
"
" If completion not showing up with you type in insert mode then
" check which scripts are loaded with :scriptnames

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

set omnifunc=v:lua.vim.lsp.omnifunc

