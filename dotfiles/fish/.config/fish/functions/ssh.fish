# function ssh
#   # xterm-kitty replacement since not generally available
#   # https://github.com/kovidgoyal/kitty/issues/879
#   if test "$TERM" = "xterm-kitty"
#     TERM=kitty /usr/bin/ssh $argv
#   else
#     /usr/bin/ssh $argv
#   end
# end
