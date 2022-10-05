if get(g:, "knobs_level", 0) == 1
  finish
endif

if !exists("g:knob_window_cleaner")
  finish
endif

command! -nargs=0 CloseOtherBuffers :call window#cleaner#CloseOtherBuffers()
command! -nargs=0 CloseMe :call window#cleaner#CloseMe()

nnoremap <silent> <leader>o :CloseOtherBuffers<CR>

" Quit and save/close are handy leaders for use on mobile and limited keyboard
nnoremap <silent> <leader>q :CloseMe<CR>
nnoremap <silent> <leader>x :x<CR>
" I don't use macros, q to quit is more convenient for me
nnoremap <silent> q :CloseMe<CR>


