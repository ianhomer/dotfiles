if exists('g:knobs_runtime_autoloaded')
  finish
endif
let g:knobs_runtime_autoloaded = 1

" Reload vimrc, neo vimrc
function! knobs#runtime#ReloadConfig()
  silent! wall
  if exists("g:init_vim")
    exec "source ".g:vim_init_file
  endif
  " Source local plugin files too, since not explicitly referenced in init file
  for plugin_file in split(globpath(g:vim_local_plugin_dir, '*'), '\n')
    exec "source ".plugin_file
  endfor
  let config_message = has('nvim') ? "neo init.vm" : ".vimrc"
  if &modifiable && expand('%:p') != ""
    normal ma
    " Reload current buffer to allow any filetype plugins to take effect
    silent edit
    normal `a
  endif
endfunction

function! knobs#runtime#RestartConfig()
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
  call knobs#runtime#ReloadConfig()
endfunction
