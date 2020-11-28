function knobs#ListFeatures(ArgLead, CmdLind, CursorPos)
  return sort(filter(keys(g:toggles), 'stridx(v:val,"'.a:ArgLead.'") == 0'))
endfunction

function knobs#ToggleFeature(feature)
  call knobs#SetFeature(a:feature, has_key(g:toggles, a:feature) ? !g:toggles[a:feature] : 1)
  call ReloadConfig()
endfunction

function knobs#ToggleLayer(layer)
  let g:layers[a:layer] = !g:layers[a:layer]
  call knobs#ApplyLayer(a:layer, g:layers[a:layer])
  call ReloadConfig()
endfunction

function knobs#ConfigLevel(level)
  let g:config_level_session=a:level
  if g:config_level == 0
    set all&
  endif
  call knobs#ApplyLevels()
  call ReloadConfig()
endfunction

function knobs#SetFeature(feature, value)
  let g:toggles[a:feature] = a:value
  echom a:feature . " " . (a:value ? "on" : "off")
endfunction

function knobs#ApplyLayer(layer, enabled)
  for [feature,value] in items(g:layer_features[a:layer])
    call knobs#SetFeature(feature, a:enabled ? value : 1 - value)
  endfor
endfunction

" Apply feature toggles for all layers
function knobs#ApplyLayers()
  for [layer,enabled] in items(g:layers)
    if enabled
      call knobs#ApplyLayer(layer, enabled)
    endif
  endfor
endfunction

" Apply feature toggles for all layers
function knobs#ApplyLevels()
  for [feature,level] in items(g:level_features)
    call knobs#SetFeature(feature,
      \ (level <= g:config_level ? 1 : 0))
  endfor
endfunction

function knobs#Toggles()
  echo g:toggles
endfunction


