#!/bin/bash

function time::start() {
  export TIME_START=$(gdate +%s%N)
}

function time::mark() {
  TIME_MARK=$(gdate +%s%N)
}

function time::() {
  time=$(gdate +%s%N)
  printf "⨂ %-20s : %8sµs\n" \
    "$1" $(( ( $time - $TIME_START ) / 1000 ))
}

function time::block() {
  time=$(gdate +%s%N)
  count=${2:-1}
  printf "↳ %-20s :         %8sµs\n" \
    "$1" $(( ( $time - $TIME_MARK ) / ( 1000 * $count) ))
}

function time::command() {
  command="$1"
  label=${2:-$command}
  count=${3:-10}
  time::mark
  for run in $(seq $count) ; do eval "$command"  ; done
  time::block "$label" $count
}



