"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"

if exists('g:knobs_autoloaded')
  finish
endif
let g:knobs_autoloaded = 1

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

function! knobs#(knob)
  return has_key(g:knobs, a:knob) ? g:knobs[a:knob] : 0
endfunction

function! knobs#If(knob, ...)
  if knobs#(trim(a:knob,"'"))
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
