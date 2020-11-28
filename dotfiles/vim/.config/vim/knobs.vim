let g:knobs_default_level = 2

" Default values for the feature toggles
let g:default_toggles = {
  \   "coco":0,
  \   "compactcmd":0,
  \   "conflict-marker":0,
  \   "markdown.flow":0,
  \   "markdown.conceal.full":0,
  \   "markdown.conceal.partial":0,
  \   "markdown.syntax.list":0,
  \   "markdown.syntax.table":1,
  \   "polyglot":0,
  \   "syntastic":0,
  \   "writegood":0
  \ }

" Config levels at which features are enabled
let g:level_features = {
  \   "ale":5,
  \   "apathy":5,
  \   "airline":5,
  \   "autosave":4,
  \   "conflict-marker":7,
  \   "dispatch":5,
  \   "endwise":5,
  \   "eunuch":5,
  \   "fugitive":5,
  \   "fzf":5,
  \   "gitgutter":5,
  \   "gruvbox":5,
  \   "goyo":5,
  \   "nerdtree":5,
  \   "modes":5,
  \   "nnn":6,
  \   "spelling":5,
  \   "startify":5,
  \   "startuptime":5,
  \   "surround":5,
  \   "tabcomplete":5,
  \   "tabular":5,
  \   "thingity":5,
  \   "unimpaired":5,
  \   "update-spelling":5,
  \   "which-key":5,
  \   "window-cleaner":5
  \ }

" Feature toggles triggered by each layer
let g:layer_features = {
  \    "mobile":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown.flow":1,
  \      "markdown.conceal.full":1,
  \      "markdown.syntax.list":1
  \    },
  \    "notes":{
  \      "compactcmd":1,
  \      "light":1,
  \      "markdown.conceal.partial":1
  \    }
  \  }


" Default state of layers
" iTerm used for notes layer
let g:layers = get(g:, "layers",{
  \   "mobile": $ANDROID_DATA == '/data' ? 1 : 0,
  \   "notes": $ITERM_PROFILE == 'oh-my' ? 1 : 0   
  \ })

"
" Quick finish if config level is 0
"
call knobs#core#Bootstrap()
if knobs#core#Level() == 0
  finish
endif

silent call knobs#Initialise()
