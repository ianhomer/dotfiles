if exists('g:knobs_core_autoloaded')
  finish
endif
let g:knobs_core_autoloaded = 1

function knobs#core#ListKnobs(ArgLead, CmdLind, CursorPos)
  return sort(filter(keys(g:knobs), 'stridx(v:val,"'.a:ArgLead.'") == 0'))
endfunction

function knobs#core#Toggle(knob)
  call knobs#core#SetKnob(a:knob, 
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

function! knobs#core#SetKnob(knob, value)
  let g:knobs[a:knob] = a:value
  let knob_name = "g:knob_" . a:knob
  if a:value > 0
    let {knob_name} = a:value
  "elseif exists(name)
  "  unlet {name}
  endif
endfunction

function! knobs#core#ApplyLayer(layer, enabled)
  for [feature,value] in items(g:knobs_layers_map[a:layer])
    call knobs#core#SetKnob(feature, a:enabled ? value : 1 - value)
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
    call knobs#core#SetKnob(knob, knobs#At(level))
  endfor
endfunction

function! knobs#core#Knobs()
  echo sort(filter(keys(g:knobs),'g:knobs[v:val]'))
endfunction

" Reload vimrc, neo vimrc and CoC
function! knobs#core#ReloadConfig()
  silent! wall
  let config_file = has('nvim') ? "~/.config/nvim/init.vim" : "~/.vimrc"
  exec "source ".config_file
  call knobs#core#RestartConfig()
  let config_message = has('nvim') ? "neo init.vm" : ".vimrc"
  let extra_message = exists("*CocRestart") ? " with CoC" : ""
  if !exists(":CocRestart")
    " only display message if CoC not enabled, it it is enabled, this extra
    " message causes overload in the 2 row command window
    echo "Reloaded ".config_message.extra_message" - level = ".g:knobs_level
  endif
  if &modifiable && expand('%:p') != ""
    normal ma
    " Reload current buffer to allow any filetype plugins to take effect
    silent edit
    normal `a
  endif
endfunction

function! knobs#core#RestartConfig()
  if exists(":CocRestart")
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
