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
    OK) shift && _status OK ${@} ;;
    AOK) shift && _status AOK ${@} ;;
    NOK) shift && _status NOK ${@} ;;
    *) _info ${@}
  esac
}

#
# Sometimes _ looks cleaner, I'll try both for a bit to see witch I like
#

function _() {
  o_o $@
}

#
# Output status of a thing
#
function _status() {
  status=$1
  thing=$2
  message=$3
  [[ "$status" == "NOK" ]] && color="33" || color="36"
  printf "\e[36m%-10s \e[${color}m \e[1m%-5s\e[38;5;238m%s\e[0m\n" "$thing" \
    "$status" "$message"
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

function dim() {
  printf "\e[2m$*\e[0m"
}

function invert() {
  printf "\e[7m$*\e[0m"
}

function _palette() {
  printf "\e[39m%10s\e[0m" default
  printf "\e[30m%10s\e[0m" black
  printf "\e[90m%10s\e[0m" "d grey"
  printf "\e[37m%10s\e[0m" "l grey"
  printf "\e[97m%10s\e[0m\n" "white"
  printf "\e[31m%10s\e[0m" red
  printf "\e[91m%10s\e[0m" "l red"
  printf "\e[32m%10s\e[0m" green
  printf "\e[92m%10s\e[0m\n" "l green"
  printf "\e[33m%10s\e[0m" yellow
  printf "\e[93m%10s\e[0m" "l yellow"
  printf "\e[34m%10s\e[0m" blue
  printf "\e[94m%10s\e[0m\n" "l blue"
  printf "\e[35m%10s\e[0m" magneta
  printf "\e[95m%10s\e[0m" "l magneta"
  printf "\e[36m%10s\e[0m" cyan
  printf "\e[96m%10s\e[0m\n" "l cyan"
  invert invert
  dim dim
  printf "\e[37m"
  dim dim light grey
  printf "\e[0m\n"
  printf "\e[38;5;238m%10s\e[0m\n" "very light grey"
  printf "\e[48;5;238m%10s\e[0m\n" "very light grey"
  for i in {1..7} ; do for j in {1..31} ; do 
    printf "\e[38;5;$(( i*32 + j))m─\e[0m" ;
  done ; printf "\n" ; done ; echo
  for i in {0..7} ; do for j in {0..31} ; do
    printf "\e[48;5;$(( i*32 + j))m \e[0m" ;
  done ; printf "\n" ; done ; echo
}
