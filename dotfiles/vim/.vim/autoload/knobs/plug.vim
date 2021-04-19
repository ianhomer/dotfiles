" Functions that helped before I discovered packer

" Could this knob be needed, e.g. if knob level was higher
function! knobs#plug#could(knob)
  " https://en.wikipedia.org/wiki/Up_to_eleven - everything on
  if g:knobs_level == 11
    return 1
  endif
  return knobs#(a:knob)
endfunction

function! knobs#plug#If(knob, ...)
  if knobs#(trim(a:knob,"'")) || g:knobs_level == 11
    execute join(a:000)
  endif
endfunction


