let g:abolish_save_file = expand('<sfile>')

cabbrev grpe grep
cabbrev Ggrpe Ggrep
cabbrev GIt Git

if !exists(":Abolish")
  finish
endif

" Abolish configurations
Abolish delimeter{,s}                         delimiter{}
Abolish despara{te,tely,tion}                 despera{}
Abolish persistan{ce,t,tly}                   persisten{}
Abolish {,ir}releven{ce,cy,t,tly}             {}relevan{}
Abolish reproducable                          reproducible
Abolish Tqbf        The quick, brown fox jumps over the lazy dog
Abolish Lidsa       Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
