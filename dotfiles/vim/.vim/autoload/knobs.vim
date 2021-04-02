"
" Core functions for knobs that are loaded early and can support a very minimal
" set up
"

if exists('g:knobs_autoloaded')
  finish
endif
let g:knobs_autoloaded = 1

" Default values for knobs
let g:knobs_defaults = {
  \   "compactcmd":0,
  \   "markdown_flow":0,
  \   "markdown_conceal_full":0,
  \   "markdown_conceal_partial":0,
  \   "markdown_syntax_list":0,
  \   "markdown_syntax_table":1,
  \   "polyglot":0,
  \   "syntastic":0,
  \   "startuptime":0
  \ }

" Levels at which knobs are enabled
let g:knobs_levels = {
  \   "ale":4,
  \   "apathy":5,
  \   "airline":5,
  \   "autosave":4,
  \   "chadtree":7,
  \   "colorbuddy":6,
  \   "conflict_marker":7,
  \   "compe":5,
  \   "devicons":5,
  \   "dispatch":5,
  \   "endwise":5,
  \   "eunuch":5,
  \   "fugitive":4,
  \   "fzf":4,
  \   "gitgutter":5,
  \   "gruvbox":5,
  \   "gruvbox8":4,
  \   "gruvbuddy":6,
  \   "goyo":4,
  \   "gutentags":5,
  \   "nerdtree":5,
  \   "lens":8,
  \   "lightbulb":5,
  \   "minimap": 5,
  \   "modes":1,
  \   "nnn":6,
  \   "polyglot":5,
  \   "spelling":4,
  \   "startify":5,
  \   "startuptime":5,
  \   "surround":4,
  \   "tabcomplete":4,
  \   "tabular":4,
  \   "thingity":4,
  \   "unimpaired":4,
  \   "update_spelling":6,
  \   "which_key":5,
  \   "window_cleaner":4,
  \   "writegood":8,
  \   "zephyr":9
  \ }

" Feature toggles triggered by each layer
let g:knobs_layers_map = {
  \    "mobile":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown_flow":1,
  \      "markdown_conceal_full":1,
  \      "markdown_syntax_list":1
  \    },
  \    "notes":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown_conceal_partial":1
  \    },
  \    "nvim-0.5":{
  \      "lsp":1
  \    }
  \  }

" Default state of layers
" iTerm used for notes layer
let g:knobs_layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0,
  \   "nvim-0.5": has('nvim-0.5') ? 1 : 0
  \ })

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
