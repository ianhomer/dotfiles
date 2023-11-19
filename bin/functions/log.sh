#!/usr/bin/env bash
# Pretty shell messages

function log::() {
  mode=$1
  case $mode in
    box) shift && log::box ${@} ;;
    error) shift && log::error ${@} ;;
    skip) shift && log::action skip ${@} ;;
    status) shift && log::status ${@} ;;
    IS) shift && log::status IS "${@}" ;;
    OK) shift && log::status OK "${@}" ;;
    AOK) shift && log::status AOK "${@}" ;;
    NOK) shift && log::status NOK "${@}" ;;
    *) log::info ${@}
  esac
}

function log::trim() {
  width=$1
  (( ${#2} > $width )) && printf "${2:0:$((width-3))}..." || printf "$2"
}

function log::box() {
  cols=`tput cols`
  left=$((cols / 2))
  right=$((cols - left))
  one=`log::trim $left "$1"`
  two=`log::trim $right "$2"`
  printf "\e[0;35m%-${left}s\e[36m%${right}s\e[0m\n" "$one" "$two"
}

function log::table() {
  cols=`tput cols`
  left="$1"
  right=$((cols - left))
  one=`log::trim "$left" "$2 "`
  two=`log::trim "$right" "$3"`
  printf "\e[0;35m%${left}s\e[36m%-${right}s\e[0m\n" "$one" "$two"
}

#
# Report the status of a thing
#
function log::status() {
  status=$1
  thing=$2
  shift; shift
  message=$@
  [[ "$status" == "NOK" ]] && color="33" || color="36"
  printf "\e[36m%-10s \e[${color}m \e[1m%-5s\e[38;5;238m%s\e[0m\n" "$thing" \
    "$status" "$message"
}

function log::trace() {
  [[ "$TRACEME" == "y" ]] && printf "\e[38;5;238m$*\e[0m\n"
  return 0
}

function log::info() {
  printf "\e[36m$*\e[0m\n"
}

function log::warn() {
  printf "\e[33m$*\e[0m\n"
}

function log::error() {
  printf "\e[31m$*\e[0m\n"
}

# Error and exit
function log::exit() {
  log::error $@
  caller
  exit 3
}

#
# Report that an action has taken place on a thing
#
function log::action() {
  action=$1
  thing=$2
  message=${*:-3}
  printf "\e[37m${action} \e[1m%-15s\e[0;37m %s\e[0m\n" "$thing" "$message"
}

function log::bold() {
  printf "\e[1m$*\e[0m"
}

function log::dim() {
  printf "\e[2m$*\e[0m"
}

function log::invert() {
  printf "\e[7m$*\e[0m"
}

function log::palette() {
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
