" Raise config level to disable configs
" - 0 => core config
" - 1 => core plugins
" - 2 => useful config
" - 3 => useful plugins
" - 4 => power config
" - 5 => power plugins
" - 6 => trial config
"   7 => trial plugins
" - 8 => experimental config
" - 9 => experimental plugins
"
" Config level can be used to reduce start up times, troubleshoot interactions
" between configurations and plugins. It can also be used to introduce new
" configuration and plugins with control.
"
let g:config_level = exists('$VIM_CONFIG_LEVEL' ) ?
  \ $VIM_CONFIG_LEVEL : exists('g:config_level_session') ?
  \ g:config_level_session : 4

let g:coc_enabled = exists('g:coc_enabled_session') ? g:coc_enabled_session : 0

" Toggle CoC mode
if !exists("*CoCToggle")
  function! CoCToggle()
    let g:coc_enabled_session = exists('g:coc_enabled_session') ?
      \ 1 - g:coc_enabled_session : 1
    if g:coc_enabled_session == 0
      CocDisable
    end
    call ReloadConfig()
    if g:coc_enabled_session == 1
      CocEnable
    end
  endfunction
  nnoremap <silent> <leader>5 :call CoCToggle()<CR>
endif

nnoremap <silent> <leader>90 :call ConfigLevel(0)<CR>
nnoremap <silent> <leader>91 :call ConfigLevel(1)<CR>
nnoremap <silent> <leader>92 :call ConfigLevel(2)<CR>
nnoremap <silent> <leader>93 :call ConfigLevel(3)<CR>
nnoremap <silent> <leader>94 :call ConfigLevel(4)<CR>
nnoremap <silent> <leader>95 :call ConfigLevel(5)<CR>
nnoremap <silent> <leader>96 :call ConfigLevel(6)<CR>
nnoremap <silent> <leader>97 :call ConfigLevel(7)<CR>
nnoremap <silent> <leader>98 :call ConfigLevel(8)<CR>
nnoremap <silent> <leader>99 :call ConfigLevel(9)<CR>

if !exists("*ConfigLevel")
  function! ConfigLevel(level)
    let g:config_level_session=a:level
    if g:config_level == 0
      set all&
    endif
    call ReloadConfig()
  endfunction
endif

