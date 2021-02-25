" My shortcuts
if KnobAt(1)
  nnoremap <silent> <leader><space> :Buffers<CR>
  nnoremap <silent> <leader>f :call my#SearchFiles()<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  " Hide all windows except the current one
  nnoremap <silent> <leader>O :only<CR>

  if KnobAt(3)
    nnoremap <silent> <leader>y :BCommits<CR>
    nnoremap <silent> <leader>Y :BCommits!<CR>
    nnoremap <silent> <leader>t :Commits<CR>
    nnoremap <silent> <leader>T :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <silent> <leader>k :call my#ToggleQuickFix()<CR>
    nnoremap <silent> <leader>K :call my#ToggleLocationList()<CR>
    nnoremap <silent> <leader>g :call window#ToggleFugitive()<CR>
    nnoremap <silent> <leader>gd :Gvdiff!<CR>
    nnoremap gdh :diffget //2<CR>
    nnoremap gdl :diffget //3<CR>
    nnoremap <silent> <leader>b :call my#GitSynk(1)<CR>
    nnoremap <silent> <leader>e :call my#GitSynk(0)<CR>

    " ... and let this q mapping apply for NERDTree
    let NERDTreeMapQuit='qq'

    "nnoremap <silent> q :echo "q disabled"<CR>

    if KnobAt(4)
      if knobs#("which-key")
        nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
        nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
      endif
      nnoremap <silent> <leader>p :MarkdownPreview<CR>
      nnoremap <silent> <leader>.m :!mind-map %:p<CR>
    endif
  endif

  nnoremap <silent> <leader>l :call my#LintMe()<CR>
  nnoremap <leader>.e <C-W><C-=>
endif

if exists('*which_key#register')
  " Note that this currently when config reloaded after which keys as been used
  " since which keys is lazily loaded
  let g:which_key_map =  {}
  let g:which_key_map.c = { 'name' : '...Commenter' }
  let g:which_key_map.j = { 'name' : '...Thingity' }
  let g:which_key_map['k'] = { 'name' : '...Bookmarks' }
  let g:which_key_map['9'] = { 'name' : '...Toggle' }
  let g:which_key_map[','] = { 'name' : '...Misc' }
  let g:which_key_map['.'] = { 'name' : '...Experimental' }
  call which_key#register('<Space>', "g:which_key_map")
  call which_key#register("'", "g:which_key_map")
endif
