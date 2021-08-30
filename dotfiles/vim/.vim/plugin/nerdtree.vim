if !knobs#("nerdtree")
  finish
endif

let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeIgnore = [ '^node_modules$' ]
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 0
let NERDTreeAutoDeleteBuffer = 1

let NERDTreeDirArrowExpandable=""
let NERDTreeDirArrowCollapsible=""
" Don't shrink menu
let NERDTreeMinimalMenu = 0

function! NERDTreeFindOrToggle()
  if (exists("g:NERDTree") && g:NERDTree.IsOpen())
    if &filetype == "startify"
      let current = bufnr("%")
      NERDTreeToggle
      execute current."bd"
    elseif winnr('$') > 1
      NERDTreeToggle
    else
      " NERDTree doesn't like closing itself if it's the last window, so we'll
      " use the CloseMe function which will drop back to Startify
      "call window#cleaner#CloseMe()
    endif
  elseif @% == ""
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction

function! NERDTreeSwitchAndFind()
  call window#SwitchToFirstEditableFile()
  NERDTreeFind
  call window#SwitchToFirstEditableFile()
endfunction

command! -nargs=0 NERDTreeFindOrToggle :call NERDTreeFindOrToggle()

nnoremap <silent> <leader>N :NERDTreeFindOrToggle<CR>
