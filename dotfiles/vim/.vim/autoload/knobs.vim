"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"

if exists('g:knobs_autoloaded')
  finish
endif
let g:knobs_autoloaded = 1

if has('nvim')
  " Store nvim plugins in isolated location
  let g:vim_config_dir = "~/.config/nvim"
else
  let g:vim_config_dir = "~/.vim"
endif
let g:vim_init_file = has('nvim') ? "~/.config/nvim/init.vim" : "~/.vimrc"
let g:vim_local_plugin_dir = "~/.vim/plugin"
let g:vim_plugged_dir = g:vim_config_dir."/plugged"

function! knobs#GetPluggedDir()
  return g:vim_plugged_dir
endfunction

function! knobs#GetConfigDir()
  return g:vim_config_dir
endfunction

function! knobs#Level()
  return g:knobs_level
endfunction

function! knobs#Init()
  if exists('g:knobs_initialised')
    return
  endif
  let g:knobs_initialised = 1

  let g:knobs_level = exists('$VIM_KNOB' ) ?
    \ $VIM_KNOB : exists('g:knobs_session_level') ?
    \ g:knobs_level_session :
    \ exists('g:knobs_default_level') ? g:knobs_default_level : 0

  " Set default state of feature toggles
  let g:knobs = get(g:, "knobs", g:knobs_defaults)

  for [key,value] in items(g:knobs)
    if value > 0
      let {"g:knob_" . key} = value
    endif
  endfor

  call s:DefineCommands()

  " Do full initialisation if config level greater than zero
  if knobs#At(1)
    silent call knobs#core#Init()
  endif
endfunction

"
" Commands and functions used in vimrc. Further commands used after spin up
" should be defined in plugin/knobs.vim.
"
function! s:DefineCommands()
  if !exists("*IfKnob")
    command! -nargs=+ -bar IfKnob call knobs#If(<f-args>)
  endif

  " Shortcuts to functions
  if !exists("*Knob")
    function! Knob(feature)
      return knobs#(a:feature)
    endfunction
  endif

  if !exists("*KnobAt")
    function! KnobAt(level)
      return knobs#At(a:level)
    endfunction
  endif
endfunction

" Could this knob be needed, e.g. if knob level was higher
function! knobs#could(knob)
  " https://en.wikipedia.org/wiki/Up_to_eleven - everything on
  if g:knobs_level == 11
    return 1
  endif
  return knobs#(a:knob)
endfunction

function! knobs#(knob)
  return exists("g:knob_" . a:knob)
endfunction

function! knobs#If(knob, ...)
  if knobs#(trim(a:knob,"'")) || g:knobs_level == 11
    execute join(a:000)
  endif
endfunction

function! knobs#Level()
  return g:knobs_level
endfunction

function! knobs#At(level)
  if exists("g:knobs_level")
    return g:knobs_level >= a:level
  else
    return 0
  endif
endfunction

if !exists("g:knobs_default_level")
  let g:knobs_default_level = 1
endif

call knobs#Init()
