if exists('g:knobs_core_autoloaded')
  finish
endif
let g:knobs_core_autoloaded = 1

function knobs#core#ListFeatures(ArgLead, CmdLind, CursorPos)
  return sort(filter(keys(g:knobs), 'stridx(v:val,"'.a:ArgLead.'") == 0'))
endfunction

function knobs#core#Toggle(knob)
  call knobs#core#SetFeature(a:knob, 
        \ has_key(g:knobs, a:knob) ? !g:knobs[a:knob] : 1)
  call knobs#core#ReloadConfig()
endfunction

function knobs#core#ToggleLayer(layer)
  let g:knobs_layers[a:layer] = !g:knobs_layers[a:layer]
  call knobs#core#ApplyLayer(a:layer, g:layers[a:layer])
  call knobs#core#ReloadConfig()
endfunction

function knobs#core#SetLevel(level)
  if a:level == 0
    set all&
  endif
  let g:knobs_level_session=a:level
  let g:knobs_level=a:level
  call knobs#core#ApplyLevels()
  call knobs#core#ReloadConfig()
endfunction

function! knobs#core#SetFeature(knob, value)
  let g:knobs[a:knob] = a:value
endfunction

function! knobs#core#ApplyLayer(layer, enabled)
  for [feature,value] in items(g:knobs_layers_map[a:layer])
    call knobs#core#SetFeature(feature, a:enabled ? value : 1 - value)
  endfor
endfunction

" Apply feature toggles for all layers
function! knobs#core#ApplyLayers()
  for [layer,enabled] in items(g:knobs_layers)
    if enabled
      call knobs#core#ApplyLayer(layer, enabled)
    endif
  endfor
endfunction

" Apply feature toggles for all layers
function! knobs#core#ApplyLevels()
  for [knob,level] in items(g:knobs_levels)
    call knobs#core#SetFeature(knob, knobs#At(level))
  endfor
endfunction

function! knobs#core#Toggles()
  echo g:knobs
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
    echo "Reloaded ".config_message.coc_message" - level = ".g:knobs_level
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
