" Functions that helped before I discovered packer
function! knobs#plug#RunIf(knob, ...)
  if knobs#(trim(a:knob,"'"))
    execute join(a:000)
  endif
endfunction


