"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"

if exists('g:knobs_autoloaded')
  finish
endif
let g:knobs_autoloaded = 1

function! knobs#Level()
  return g:config_level
endfunction

function! knobs#Init()
  if exists('g:knobs_initialised')
    return
  endif
  let g:knobs_initialised = 1

  let g:config_level = exists('$VIM_CONFIG_LEVEL' ) ?
    \ $VIM_CONFIG_LEVEL : exists('g:config_level_session') ?
    \ g:config_level_session : 
    \ exists('g:knobs_default_level') ? g:knobs_default_level : 0

  " Set default state of feature toggles
  let g:toggles = get(g:, "toggles", g:default_toggles)

  " Shortcuts to functions
  if !exists("*Knob") 
    function! Knob(feature)
      return knobs#IsEnabled(a:feature)
    endfunction
  endif

  if !exists("*KnobAt") 
    function! KnobAt(level)
      return knobs#At(a:level)
    endfunction
  endif

  " Do full initialisation if config level greater than zero
  if KnobAt(1)
    silent call knobs#core#Init()
  endif
endfunction

function! knobs#IsEnabled(feature)
  return has_key(g:toggles, a:feature) ? g:toggles[a:feature] : 0
endfunction

function! knobs#Level()
  return g:config_level
endfunction

function! knobs#At(level)
  if exists("g:config_level")
    return g:config_level >= a:level
  else
    return 0
  endif
endfunction

