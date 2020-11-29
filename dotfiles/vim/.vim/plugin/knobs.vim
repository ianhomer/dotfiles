if exists('g:knobs_loaded')
  finish
endif
let g:knobs_loaded = 1

"
" Toggle features and layers. Layers are typically triggered by the environment
" and can be used to toggle multiple features.
"
" Raise config level to disable configs
" - 0 => core config
" - 1 => core plugins
" - 2 => useful config
" - 3 => useful plugins
" - 4 => power config
" - 5 => power plugins
" - 6 => trial config
"   7 => trial plugins
" - 8 => experimental config
" - 9 => experimental plugins
"
" Config level can be used to reduce start up times, troubleshoot interactions
" between configurations and plugins. It can also be used to introduce new
" configuration and plugins with control.
"

command! -nargs=0 Knobs :call knobs#Toggles()
command! -nargs=0 KnobLevel :echo knobs#core#Level()
command! -nargs=1 -complete=customlist,knobs#ListFeatures
  \ KnobToggle :call knobs#Toggle(<q-args>)

nnoremap <silent> <leader>v :call knobs#ReloadConfig()<CR>

nnoremap <silent> <leader>9a :call knobs#core#ToggleFeature("ale")<CR>
nnoremap <silent> <leader>9c :call knobs#ToggleFeature("coc")<CR>
nnoremap <silent> <leader>9j :call knobs#ToggleLayer("notes")<CR>
nnoremap <silent> <leader>9l :call knobs#ToggleFeature("light")<CR>
nnoremap <silent> <leader>9m :call knobs#ToggleLayer("mobile")<CR>
nnoremap <silent> <leader>9n :call knobs#ToggleFeature("nerdtree")<CR>
nnoremap <silent> <leader>9g :call knobs#ToggleFeature("gitgutter")<CR>
nnoremap <silent> <leader>9s :call knobs#ToggleFeature("syntastic")<CR>
nnoremap <silent> <leader>9w :call knobs#ToggleFeature("writegood")<CR>

nnoremap <silent> <leader>90 :call knobs#SetLevel(0)<CR>
nnoremap <silent> <leader>91 :call knobs#SetLevel(1)<CR>
nnoremap <silent> <leader>92 :call knobs#SetLevel(2)<CR>
nnoremap <silent> <leader>93 :call knobs#SetLevel(3)<CR>
nnoremap <silent> <leader>94 :call knobs#SetLevel(4)<CR>
nnoremap <silent> <leader>95 :call knobs#SetLevel(5)<CR>
nnoremap <silent> <leader>96 :call knobs#SetLevel(6)<CR>
nnoremap <silent> <leader>97 :call knobs#SetLevel(7)<CR>
nnoremap <silent> <leader>98 :call knobs#SetLevel(8)<CR>
nnoremap <silent> <leader>99 :call knobs#SetLevel(9)<CR>
