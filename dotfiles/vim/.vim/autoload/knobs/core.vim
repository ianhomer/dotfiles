if exists('g:knobs_core_autoloaded')
  finish
endif
let g:knobs_core_autoloaded = 1

function knobs#core#ListFeatures(ArgLead, CmdLind, CursorPos)
  return sort(filter(keys(g:toggles), 'stridx(v:val,"'.a:ArgLead.'") == 0'))
endfunction

function knobs#core#Toggle(feature)
  call knobs#core#SetFeature(a:feature, 
        \ has_key(g:toggles, a:feature) ? !g:toggles[a:feature] : 1)
  call knobs#core#ReloadConfig()
endfunction

function knobs#core#ToggleLayer(layer)
  let g:layers[a:layer] = !g:layers[a:layer]
  call knobs#core#ApplyLayer(a:layer, g:layers[a:layer])
  call knobs#core#ReloadConfig()
endfunction

function knobs#core#SetLevel(level)
  if a:level == 0
    set all&
  endif
  let g:config_level_session=a:level
  let g:config_level=a:level
  call knobs#core#ApplyLevels()
  call knobs#core#ReloadConfig()
endfunction

function! knobs#core#SetFeature(feature, value)
  let g:toggles[a:feature] = a:value
endfunction

function! knobs#core#ApplyLayer(layer, enabled)
  for [feature,value] in items(g:layer_features[a:layer])
    call knobs#core#SetFeature(feature, a:enabled ? value : 1 - value)
  endfor
endfunction

" Apply feature toggles for all layers
function! knobs#core#ApplyLayers()
  for [layer,enabled] in items(g:layers)
    if enabled
      call knobs#core#ApplyLayer(layer, enabled)
    endif
  endfor
endfunction

" Apply feature toggles for all layers
function! knobs#core#ApplyLevels()
  for [feature,level] in items(g:level_features)
    call knobs#core#SetFeature(feature, knobs#At(level))
  endfor
endfunction

function! knobs#core#Toggles()
  echo g:toggles
endfunction

" Reload vimrc, neo vimrc and CoC
function! knobs#core#ReloadConfig()
  silent! wall
  let config_file = has('nvim') ? "~/.config/nvim/init.vim" : "~/.vimrc"
  exec "source ".config_file
  call knobs#core#RestartConfig()
  let config_message = has('nvim') ? "neo init.vm" : ".vimrc"
  let coc_message = knobs#("coc") ? " with CoC" : ""
  if !knobs#("coc")
    " only display message if CoC not enabled, it it is enabled, this extra
    " message causes overload in the 2 row command window
    echo "Reloaded ".config_message.coc_message" - level = ".g:config_level
  endif
  if expand('%:p') != ""
    normal ma
    " Reload current buffer
    silent edit
    normal `a
  endif
endfunction

function! knobs#core#RestartConfig()
  if knobs#("coc")
    CocRestart
  endif
endfunction

function! knobs#core#Init()
  if exists('g:knobs_core_initialised')
    return
  endif
  let g:knobs_core_initialised = 1

  " Apply all levels during initialisation
  call knobs#core#ApplyLevels()

  " Apply all layers during initialisation
  call knobs#core#ApplyLayers()
endfunction
