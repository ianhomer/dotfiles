#!/bin/bash
function time::start() {
  export TIME_START=`gdate +%s%N`
}

function time::mark() {
  export TIME_MARK=`gdate +%s%N`
}

function time::me() {
  time=`gdate +%s%N`
  printf "⨂ %-20s : %8sµs\n" \
    "$1" $(( ( $time - $TIME_START ) / 1000 ))
}

function time::block() {
  time=`gdate +%s%N`
  count=${2:-1}
  printf "↳ %-20s :         %8sµs\n" \
    "$1" $(( ( $time - $TIME_MARK ) / ( 1000 * $count) ))
}


