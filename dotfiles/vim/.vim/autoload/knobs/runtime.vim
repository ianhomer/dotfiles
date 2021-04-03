if exists('g:knobs_runtime_autoloaded')
  finish
endif
let g:knobs_runtime_autoloaded = 1

" Reload vimrc, neo vimrc and CoC
function! knobs#runtime#ReloadConfig()
  silent! wall
  if exists("g:init_vim")
    exec "source ".g:vim_init_file
  endif
  " Source local plugin files too, since not explicitly referenced in init file
  for plugin_file in split(globpath(g:vim_local_plugin_dir, '*'), '\n')
    exec "source ".plugin_file
  endfor
  call knobs#runtime#RestartConfig()
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

function! knobs#runtime#RestartConfig()
  if exists(":CocRestart")
    CocRestart
  endif
endfunction

function knobs#runtime#Toggle(knob)
  call knobs#core#SetKnob(a:knob, 
        \ has_key(g:knobs, a:knob) ? !g:knobs[a:knob] : 1)
  call knobs#core#ReloadConfig()
endfunction

function knobs#runtime#ToggleLayer(layer)
  let g:knobs_layers[a:layer] = !g:knobs_layers[a:layer]
  call knobs#runtime#ApplyLayer(a:layer, g:layers[a:layer])
  call knobs#runtime#ReloadConfig()
endfunction

function knobs#runtime#ListKnobs(ArgLead, CmdLind, CursorPos)
  return sort(filter(keys(g:knobs), 'stridx(v:val,"'.a:ArgLead.'") == 0'))
endfunction

function! knobs#runtime#Knobs()
  echo sort(filter(keys(g:knobs),'g:knobs[v:val]'))
endfunction

function knobs#runtime#SetLevel(level)
  if a:level == 0
    set all&
  endif
  let g:knobs_level_session=a:level
  let g:knobs_level=a:level
  call knobs#core#ApplyLevels()
  call knobs#core#ReloadConfig()
endfunction
