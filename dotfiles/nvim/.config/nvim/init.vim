set runtimepath^=/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Reload neo vimrc
nnoremap <leader>nc :source ~/.config/nvim/init.vim<CR>:echo "Reloaded neo init.vm"<CR>




