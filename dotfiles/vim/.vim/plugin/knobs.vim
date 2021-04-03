if exists('g:knobs_loaded')
  finish
endif
let g:knobs_loaded = 1

"
" Toggle features and layers. Layers are typically triggered by the environment
" and can be used to toggle multiple features.
"
" Raise config level to enable more configuration
" - 0 => basic config
" - 1 => runtime config - recommended default level
" - 2 => useful config (stable)
" - 3 => useful config
" - 4 => power config (stable)
" - 5 => power config - recommended when opening vim explicitly
" - 6 => extra config (stable)
"   7 => extra plugins
" - 8 => experimental config
" - 9 => experimental plugins
"
" Config level can be used to reduce start up times, troubleshoot interactions
" between configurations and plugins. It can also be used to introduce new
" configuration and plugins with control.
"

command! -nargs=0 Knobs :call knobs#runtime#Knobs()
command! -nargs=0 KnobLevel :echo knobs#Level()
command! -nargs=1 -complete=customlist,knobs#runtime#ListKnobs
  \ KnobToggle :call knobs#runtime#Toggle(<q-args>)

nnoremap <silent> <leader>v :call knobs#runtime#ReloadConfig()<CR>

nnoremap <silent> <leader>9a :call knobs#runtime#Toggle("ale")<CR>
nnoremap <silent> <leader>9b :call knobs#runtime#Toggle("autosave")<CR>
nnoremap <silent> <leader>9c :call knobs#runtime#Toggle("coc")<CR>
nnoremap <silent> <leader>9j :call knobs#runtime#ToggleLayer("notes")<CR>
nnoremap <silent> <leader>9l :call knobs#runtime#Toggle("light")<CR>
nnoremap <silent> <leader>9m :call knobs#runtime#ToggleLayer("mobile")<CR>
nnoremap <silent> <leader>9n :call knobs#runtime#Toggle("nerdtree")<CR>
nnoremap <silent> <leader>9p :call knobs#runtime#Toggle("polyglot")<CR>
nnoremap <silent> <leader>9g :call knobs#runtime#Toggle("gitgutter")<CR>
nnoremap <silent> <leader>9s :call knobs#runtime#Toggle("syntastic")<CR>
nnoremap <silent> <leader>9w :call knobs#runtime#Toggle("writegood")<CR>

nnoremap <silent> <leader>90 :call knobs#runtime#SetLevel(0)<CR>
nnoremap <silent> <leader>91 :call knobs#runtime#SetLevel(1)<CR>
nnoremap <silent> <leader>92 :call knobs#runtime#SetLevel(2)<CR>
nnoremap <silent> <leader>93 :call knobs#runtime#SetLevel(3)<CR>
nnoremap <silent> <leader>94 :call knobs#runtime#SetLevel(4)<CR>
nnoremap <silent> <leader>95 :call knobs#runtime#SetLevel(5)<CR>
nnoremap <silent> <leader>96 :call knobs#runtime#SetLevel(6)<CR>
nnoremap <silent> <leader>97 :call knobs#runtime#SetLevel(7)<CR>
nnoremap <silent> <leader>98 :call knobs#runtime#SetLevel(8)<CR>
nnoremap <silent> <leader>99 :call knobs#runtime#SetLevel(9)<CR>
