nnoremap <silent> <leader>o :call window#cleaner#CloseOtherBuffers()<CR>

" Quit and save/close are handy leaders for use on mobile and limited keyboard
nnoremap <silent> <leader>q :call window#cleaner#CloseMe()<CR>
nnoremap <silent> <leader>x :x<CR>
" I don't use macros, q to quit is more convenient for me
nnoremap <silent> q :call window#cleaner#CloseMe()<CR>

