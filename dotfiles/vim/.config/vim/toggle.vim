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
let g:config_level = exists('$VIM_CONFIG_LEVEL' ) ?
  \ $VIM_CONFIG_LEVEL : exists('g:config_level_session') ?
  \ g:config_level_session : 4

" Default values for the feature toggles
let g:default_toggles = {
  \   "ale":1,
  \   "airline":1,
  \   "autosave":1,
  \   "coco":0,
  \   "compactcmd":0,
  \   "markdown.flow":0,
  \   "markdown.conceal.full":0,
  \   "markdown.syntax.list":0,
  \   "markdown.syntax.table":1,
  \   "gitgutter":1, 
  \   "nerdtree":1,
  \   "polyglot":0,
  \   "syntastic":0,
  \   "writegood":0
  \ }

" Feature toggles triggered by each layer
let g:layer_features = {
  \    "mobile":{
  \      "markdown.flow":1,
  \      "markdown.conceal.full":1,
  \      "markdown.syntax.list":1
  \    },
  \    "notes":{
  \       "compactcmd":1,
  \       "light":1,
  \       "markdown.flow":1,
  \    }
  \  }

" Default state of layers
" iTerm used for notes layer
let g:layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0   
  \ })

" Set default state of feature toggles
let g:toggles = get(g:, "toggles", g:default_toggles)

if !exists("*ToggleFeature")
  function ToggleFeature(feature)
    call SetFeature(a:feature, has_key(g:toggles, a:feature) ? !g:toggles[a:feature] : 1)
    call ReloadConfig()
  endfunction
endif

if !exists("*ToggleLayer")
  function ToggleLayer(layer)
    let g:layers[a:layer] = !g:layers[a:layer]
    call ApplyLayer(a:layer, g:layers[a:layer])
    call ReloadConfig()
  endfunction
endif

if !exists("*ConfigLevel")
  function ConfigLevel(level)
    let g:config_level_session=a:level
    if g:config_level == 0
      set all&
    endif
    call ReloadConfig()
  endfunction
endif

function SetFeature(feature, value)
  let g:toggles[a:feature] = a:value
  echom a:feature . " " . (a:value ? "on" : "off")
endfunction

function! ApplyLayer(layer, enabled)
  for [feature,value] in items(g:layer_features[a:layer])
    call SetFeature(feature, a:enabled ? value : 1 - value)
  endfor
endfunction

if !exists("*ApplyLayers")
  " Apply feature toggles for all layers
  function! ApplyLayers()
    for [layer,enabled] in items(g:layers)
      call ApplyLayer(layer, enabled)
    endfor
  endfunction
  " Apply all layers during initialisation
  silent call ApplyLayers()
endif

function! IsEnabled(feature)
  return has_key(g:toggles, a:feature) ? g:toggles[a:feature] : 0
endfunction

function! IsNotEnabled(feature)
  return 1 - IsEnabled(a:feature)
endfunction


nnoremap <silent> <leader>9a :call ToggleFeature("ale")<CR>
nnoremap <silent> <leader>9c :call ToggleFeature("coc")<CR>
nnoremap <silent> <leader>9j :call ToggleLayer("notes")<CR>
nnoremap <silent> <leader>9l :call ToggleFeature("light")<CR>
nnoremap <silent> <leader>9m :call ToggleLayer("mobile")<CR>
nnoremap <silent> <leader>9n :call ToggleFeature("nerdtree")<CR>
nnoremap <silent> <leader>9g :call ToggleFeature("gitgutter")<CR>
nnoremap <silent> <leader>9s :call ToggleFeature("syntastic")<CR>
nnoremap <silent> <leader>9w :call ToggleFeature("writegood")<CR>


nnoremap <silent> <leader>90 :call ConfigLevel(0)<CR>
nnoremap <silent> <leader>91 :call ConfigLevel(1)<CR>
nnoremap <silent> <leader>92 :call ConfigLevel(2)<CR>
nnoremap <silent> <leader>93 :call ConfigLevel(3)<CR>
nnoremap <silent> <leader>94 :call ConfigLevel(4)<CR>
nnoremap <silent> <leader>95 :call ConfigLevel(5)<CR>
nnoremap <silent> <leader>96 :call ConfigLevel(6)<CR>
nnoremap <silent> <leader>97 :call ConfigLevel(7)<CR>
nnoremap <silent> <leader>98 :call ConfigLevel(8)<CR>
nnoremap <silent> <leader>99 :call ConfigLevel(9)<CR>

