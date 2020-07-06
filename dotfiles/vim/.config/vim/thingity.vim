" Insert time stamp - as markdown header
function! s:ThingityDateHeading()
  " Top level heading if first line
  let heading = line('.') == 1 ? "# " : "## "
  return heading . toupper(strftime("%a %d %b %Y"))
endfunction

nnoremap <silent> <leader>jd "=<SID>ThingityDateHeading()<CR>pj
