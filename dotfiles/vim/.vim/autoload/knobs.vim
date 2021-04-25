"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"

if exists('g:knobs_autoloaded')
  finish
endif
let g:knobs_autoloaded = 1

if !exists("g:knobs_default_level")
  let g:knobs_default_level = 1
endif

if !exists('g:knobs_levels')
  let g:knobs_levels={}
endif

" Default state of layers
" iTerm used for notes layer
let g:knobs_layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0,
  \   "nvim_0_5": has('nvim-0.5') ? 1 : 0
  \ })

if has('nvim')
  " Store nvim plugins in isolated location
  let g:vim_config_dir = "~/.config/nvim"
else
  let g:vim_config_dir = "~/.vim"
endif
let g:vim_init_file = has('nvim') ? "~/.config/nvim/init.lua" : "~/.vimrc"
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

  if exists('g:knobs_defaults')
    let g:knobs = get(g:, "knobs", g:knobs_defaults)

    for [key,value] in items(g:knobs)
      if value > 0
        let {"g:knob_" . key} = value
      endif
    endfor
  else
    let g:knobs = {}
  endif

  call s:DefineCommands()

  " Do full initialisation if config level greater than zero
  if knobs#At(1)
    call knobs#core#Init()
  endif
endfunction

"
" Commands and functions used in vimrc. Further commands used after spin up
" should be defined in plugin/knobs.vim.
"
function! s:DefineCommands()
  if !exists("*IfKnob")
    command! -nargs=+ -bar IfKnob call knobs#plug#If(<f-args>)
  endif
endfunction

function! knobs#(knob)
  return exists("g:knob_" . a:knob)
endfunction

function! knobs#Level()
  return g:knobs_level
endfunction

function! knobs#At(level)
  return g:knobs_level >= a:level
endfunction

call knobs#Init()
