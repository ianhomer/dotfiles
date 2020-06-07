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
  \ $VIM_COFIG_LEVEL : exists('g:config_level_session') ?
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


