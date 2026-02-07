cursor_block='\e[2 q'
cursor_beam='\e[6 q'

function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne $cursor_block ;;
    viins|main) echo -ne $cursor_beam ;;
  esac
}

zle-line-init() {
  echo -ne $cursor_beam
}
#
zle -N zle-keymap-select
zle -N zle-line-init
