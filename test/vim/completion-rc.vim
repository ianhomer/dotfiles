"
" Test with
"
" nvim -u test/vim/completion-rc.vim test/vim/completion-rc.vim
" nvim -u test/vim/completion-rc.vim test/scratch.ts

set runtimepath^=~/.vim-slim
set runtimepath-=~/.config/nvim/after
let &packpath = &runtimepath
call plug#begin('~/.config/nvim/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'neovim/nvim-lsp'
    Plug 'nvim-lua/completion-nvim'
call plug#end()

lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vimls.setup{on_attach=require'completion'.on_attach}

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
