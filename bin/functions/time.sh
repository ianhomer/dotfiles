#!/bin/bash


function time::start() {
  export TIME_START=$(gdate +%s%6N)
}

function time::mark() {
  TIME_MARK=$(gdate +%s%6N)
}

function time::() {
  time=$(gdate +%s%6N)
  printf "⨂ %-20s : %8sµs\n" \
    "$1" $(( ( $time - $TIME_START ) ))
}

function time::block() {
  time=$(gdate +%s%6N)
  count=${2:-1}
  printf "↳ %-20s :         %8sµs\n" \
    "$1" $(( ( $time - $TIME_MARK ) / $count ))
}

function time::command() {
  command="$1"
  label=${2:-$command}
  count=${3:-10}
  time::mark
  for run in $(seq $count) ; do eval "$command"  ; done
  time::block "$label" $count
}



