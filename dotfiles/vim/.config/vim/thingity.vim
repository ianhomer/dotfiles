" Insert time stamp - as markdown header
function! s:ThingityDateHeading()
  " Top level heading if first line
  let heading = line('.') == 1 ? "# " : "## "
  return heading . toupper(strftime("%a %d %b %Y"))
endfunction

nnoremap <silent> <leader>jd "=<SID>ThingityDateHeading()<CR>po<ESC>o<ESC>

" Search variations

" just markdown files 
nnoremap <silent> <leader>jm :call fzf#vim#files('~/projects/things', {'source':'fd -L .md'})<CR>

command! -bang -nargs=* AgMarkdown
  \ call fzf#vim#ag(<q-args>, 
  \  '-p ~/.dotfiles/config/ag/.ignore -G .md', {
  \   'options': '--delimiter : --nth 4..'
  \ }, 
  \ <bang>0)

nnoremap <silent> <leader>jf :AgMarkdown<CR>


" Hidden search
nnoremap <silent> <leader>jh :AgHidden<CR>
" generic search (experimental alternative to Ag)
nnoremap <silent> <leader>ja :Search<CR>

" todos
nnoremap <silent> <leader>jT :Ag! \[\ \]<CR>
" todos
nnoremap <silent> <leader>jt :AgPopup \[\ \]<CR>


