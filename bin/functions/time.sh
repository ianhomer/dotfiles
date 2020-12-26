#!/usr/bin/env bash

if [[ -n "$EPOCHREALTIME" ]] ; then
  function time::ms() {
    echo ${EPOCHREALTIME//.}
  }
else
  function time::ms() {
      gdate +%s%6N
  }
fi

function time::start() {
  export TIME_START=$(time::ms)
}

function time::mark() {
  TIME_MARK=$(time::ms)
}

function time::() {
  time=$(time::ms)
  printf "⨂ %-20s : %8sµs\n" \
    "$1" $(( ( $time - $TIME_START ) ))
}

function time::block() {
  time=$(time::ms)
  count=${2:-1}
  printf "↳ %-20s :         %8sµs\n" \
    "$1" $(( ( $time - $TIME_MARK ) / $count ))
}

function time::command() {
  command="$1"
  label=${2:-$command}
  count=${3:-10}
  time::mark
  for run in $(seq $count) ; do eval "$command" ; done
  time::block "$label" $count
}

function time::function() {
  label=${2}
  count=${3:-10}
  time::mark
  for run in $(seq $count) ; do "$1" ; done
  time::block "$label" $count
}




