"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"
function! knobs#core#Level()
  return g:config_level
endfunction

function! knobs#core#Init()
  if exists('g:knobs_core_initialised')
    return
  endif
  let g:knobs_core_initialised = 1

  let g:config_level = exists('$VIM_CONFIG_LEVEL' ) ?
    \ $VIM_CONFIG_LEVEL : exists('g:config_level_session') ?
    \ g:config_level_session : 
    \ exists('g:knobs_default_level') ? g:knobs_default_level : 0

  " Set default state of feature toggles
  let g:toggles = get(g:, "toggles", g:default_toggles)

  " Shortcuts to functions
  function! Knob(feature)
    return knobs#core#IsEnabled(a:feature)
  endfunction

  function! KnobAt(level)
    return g:config_level >= a:level
  endfunction

  if KnobAt(1)
    silent call knobs#Init()
  endif
endfunction

function! knobs#core#IsEnabled(feature)
  return has_key(g:toggles, a:feature) ? g:toggles[a:feature] : 0
endfunction

function! knobs#core#Level()
  return g:config_level
endfunction

