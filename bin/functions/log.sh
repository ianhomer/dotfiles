# Pretty shell messages

# 
# o_o is a shell logger - it looks like a tape roll
#
function o_o() {
  mode=$1
  case $mode in
    error) shift && _error ${@} ;;
    skip) shift && _skip ${@} ;;
    status) shift && _status ${@} ;;
    *) _info ${@}
  esac
}

#
# Sometimes _ looks cleaner, I'll try both for a bit to see witch I like
#

function _() {
  o_o $@
}

function _status() {
  printf "\e[36m%-10s \e[1m%s\e[0m\n" "$2" "$1"
}

function _info() {
  printf "\e[36m$*\e[0m\n"
}

function _error() {
  printf "\e[33m$*\e[0m\n"
}

# Error and exit
function _x() {
  _error $@
  exit 1
}

function _skip() {
  printf "\e[37mskip \e[1m%-15s\e[0;37m %s\e[0m\n" "$1" "${*:2}"
}

function bold() {
  printf "\e[1m$*\e[0m"
}
