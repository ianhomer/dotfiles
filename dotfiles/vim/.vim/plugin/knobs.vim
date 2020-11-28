if exists('g:loaded_knobs')
  finish
endif
let g:loaded_knobs = 1

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

command! -nargs=0 Toggles :call knobs#Toggles()
command! -nargs=1 -complete=customlist,knobs#ListFeatures
  \ ToggleFeature :call ToggleFeature(<q-args>)

" Apply all levels during initialisation
silent call knobs#ApplyLevels()

" Apply all layers during initialisation
silent call knobs#ApplyLayers()

nnoremap <silent> <leader>9a :call knobs#ToggleFeature("ale")<CR>
nnoremap <silent> <leader>9c :call knobs#ToggleFeature("coc")<CR>
nnoremap <silent> <leader>9j :call knobs#ToggleLayer("notes")<CR>
nnoremap <silent> <leader>9l :call knobs#ToggleFeature("light")<CR>
nnoremap <silent> <leader>9m :call knobs#ToggleLayer("mobile")<CR>
nnoremap <silent> <leader>9n :call knobs#ToggleFeature("nerdtree")<CR>
nnoremap <silent> <leader>9g :call knobs#ToggleFeature("gitgutter")<CR>
nnoremap <silent> <leader>9s :call knobs#ToggleFeature("syntastic")<CR>
nnoremap <silent> <leader>9w :call knobs#ToggleFeature("writegood")<CR>

nnoremap <silent> <leader>90 :call knobs#ConfigLevel(0)<CR>
nnoremap <silent> <leader>91 :call knobs#ConfigLevel(1)<CR>
nnoremap <silent> <leader>92 :call knobs#ConfigLevel(2)<CR>
nnoremap <silent> <leader>93 :call knobs#ConfigLevel(3)<CR>
nnoremap <silent> <leader>94 :call knobs#ConfigLevel(4)<CR>
nnoremap <silent> <leader>95 :call knobs#ConfigLevel(5)<CR>
nnoremap <silent> <leader>96 :call knobs#ConfigLevel(6)<CR>
nnoremap <silent> <leader>97 :call knobs#ConfigLevel(7)<CR>
nnoremap <silent> <leader>98 :call knobs#ConfigLevel(8)<CR>
nnoremap <silent> <leader>99 :call knobs#ConfigLevel(9)<CR>
