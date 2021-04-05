" My shortcuts
if knobs#At(1)
  nnoremap <silent> <leader><space> :Buffers<CR>
  command! -nargs=0 SearchFiles :call my#SearchFiles()
  nnoremap <silent> <leader>f :SearchFiles<CR>
  nnoremap <silent> <leader>F :Files!<CR>

  " Hide all windows except the current one
  nnoremap <silent> <leader>O :only<CR>

  if knobs#At(3)
    command! -nargs=0 ToggleQuickFix :call my#ToggleQuickFix()
    command! -nargs=0 ToggleLocationList :call my#ToggleLocationList()
    command! -nargs=0 ToggleFugitive :call window#ToggleFugitive()
    command! -nargs=0 GitPush :call my#GitSynk(1)
    command! -nargs=0 GitSynk :call my#GitSynk(0)
    
    nnoremap <silent> <leader>y :BCommits<CR>
    nnoremap <silent> <leader>Y :BCommits!<CR>
    nnoremap <silent> <leader>t :Commits<CR>
    nnoremap <silent> <leader>T :Commits!<CR>
    nnoremap <silent> <leader>h :History<CR>
    nnoremap <silent> <leader>r :reg<CR>
    nnoremap <silent> <leader>k :ToggleQuickFix<CR>
    nnoremap <silent> <leader>K :ToggleLocationList<CR>
    nnoremap <silent> <leader>g :ToggleFugitive<CR>
    nnoremap gdh :diffget //2<CR>
    nnoremap gdl :diffget //3<CR>
    nnoremap <silent> <leader>b :GitPush<CR>
    nnoremap <silent> <leader>e :GitSynk<CR>

    " ... and let this q mapping apply for NERDTree
    let NERDTreeMapQuit='qq'

    "nnoremap <silent> q :echo "q disabled"<CR>

    if knobs#At(4)
      if knobs#("which_key")
        nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
        nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
      endif
      nnoremap <silent> <leader>p :MarkdownPreview<CR>
      nnoremap <silent> <leader>.m :!mind-map %:p<CR>
    endif
  endif

  command! -nargs=0 LintMe :call my#LintMe()
  nnoremap <silent> <leader>l :LintMe<CR>
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
