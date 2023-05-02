if get(g:, "knobs_level", 0) == 1
  finish
endif

if !exists("g:knob_window_cleaner")
  finish
endif

command! -nargs=0 CloseOtherBuffers :call window#cleaner#CloseOtherBuffers()
command! -nargs=0 CloseMe :call window#cleaner#CloseMe()
command! -nargs=0 CloseTerms :call window#cleaner#CloseTerms()

nnoremap <silent> <leader>o :CloseOtherBuffers<CR>
