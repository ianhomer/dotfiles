if !exists("g:knob_shortcuts")
  finish
endif

nnoremap <silent> <leader><space> :Buffers<CR>
command! -nargs=0 SearchFiles :call my#SearchFiles()
if !knobs#("telescope")
   nnoremap <silent> <leader>f :Files!<CR>
endif
if knobs#("fzf")
  nnoremap <silent> <leader>F :Files!<CR>
  nnoremap <silent> <leader>h :History<CR>
endif

" Hide all windows except the current one
nnoremap <silent> <leader>O :only<CR>

if get(g:, "knobs_level", 0) > 2
  command! -nargs=0 ToggleQuickFix :call my#ToggleQuickFix()
  command! -nargs=0 ToggleLocationList :call my#ToggleLocationList()
  command! -nargs=0 ToggleFugitive :call window#ToggleFugitive()
  command! -nargs=0 GPush :call my#GitSynk(1)
  command! -nargs=0 GSynk :call my#GitSynk(0)

  nnoremap <silent> <leader>r :reg<CR>
  nnoremap <silent> <leader>k :ToggleQuickFix<CR>
  nnoremap <silent> <leader>K :ToggleLocationList<CR>
  nnoremap <silent> <leader>g :ToggleFugitive<CR>
  nnoremap <leader>,gdh :diffget //2<CR>
  nnoremap <leader>,gdl :diffget //3<CR>
  nnoremap <silent> <leader>b :GPush<CR>

  " ... and let this q mapping apply for NERDTree
  let NERDTreeMapQuit='qq'

  "nnoremap <silent> q :echo "q disabled"<CR>

  if exists("g:knob_which_key") && !has("nvim")
    nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
    nnoremap <silent> ' :WhichKey "'"<CR>
  endif

  nnoremap <silent> <leader>p :MarkdownPreview<CR>
  nnoremap <silent> <leader>.m :!mind-map %:p<CR>
endif

command! -nargs=0 LintMe :call my#LintMe()
nnoremap <silent> <leader>l :LintMe<CR>
nnoremap <leader>.e <C-W><C-=>
