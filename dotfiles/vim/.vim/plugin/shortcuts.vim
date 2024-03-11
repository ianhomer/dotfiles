if get(g:, "knobs_level", 0) == 1
  finish
endif
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

if get(g:, "knobs_level", 0) > 2
  command! -nargs=0 ToggleQuickFix :call my#ToggleQuickFix()
  command! -nargs=0 ToggleLocationList :call my#ToggleLocationList()
  command! -nargs=0 ToggleFugitive :call window#ToggleFugitive()
  command! -nargs=0 GPush :call my#GitSynk(1)
  command! -nargs=0 GSynk :call my#GitSynk(0)

  nnoremap <silent> <leader>g :ToggleFugitive<CR>
  nnoremap <leader>,gDh :diffget //2<CR>
  nnoremap <leader>,gDl :diffget //3<CR>
  nnoremap <silent> <leader>b :GPush<CR>

  " ... and let this q mapping apply for NERDTree
  let NERDTreeMapQuit='qq'

  if exists("g:knob_which_key") && !has("nvim")
    nnoremap <silent> <localleader> :<c-u>WhichKey  '\\'<CR>
    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
    nnoremap <silent> ' :WhichKey "'"<CR>
  endif

  if exists("g:knob_markdown_preview")
    nnoremap <silent> <leader>p :MarkdownPreview<CR>
  endif
endif

command! -nargs=0 LintMe :call my#LintMe()
command! -nargs=0 Calculate :call my#Calculate()
nnoremap <silent> <leader>l :LintMe<CR>
vnoremap <silent> <leader>c :<c-u>Calculate<CR>
