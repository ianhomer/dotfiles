"
" Core functions that are loaded early
"
function! knobs#core#Level()
  return g:config_level
endfunction

function! knobs#core#Bootstrap()
  if exists('g:knobs_bootstrapped')
    return
  endif
  let g:knobs_bootstrapped = 1
  " Set default state of feature toggles
  let g:toggles = get(g:, "toggles", g:default_toggles)

  " Shortcuts to functions
  function! IsEnabled(feature)
    return knobs#core#IsEnabled(a:feature)
  endfunction

  function! IsNotEnabled(feature)
    return 1 - IsEnabled(a:feature)
  endfunction
endfunction

function! knobs#core#IsEnabled(feature)
  return has_key(g:toggles, a:feature) ? g:toggles[a:feature] : 0
endfunction


