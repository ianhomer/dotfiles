#!/bin/bash

set -e

# Experiment with function loading

$(shim) && . ${ME}/i.sh
i:: time

time::start
time:: "start"

time::mark
for run in {1..10000} ; do : ; done
time::block "control 10000" 10000
time::command ":" "command 100" 100
time::command ":" "command 1000" 1000
time::command ":" "command 10000" 10000
time::command "sleep 0.001" "" 50

time::mark
for run in {1..10} ; do . ${DOTFILES_BIN}/functions/log.sh ; done
time::block "source log.sh 1" 10

time::command ". ${DOTFILES_BIN}/functions/log.sh" "source log.sh 2"

time::mark
for run in {1..10} ; do i::source log ; done
time::block "i::source log" 10

time::mark
for run in {1..10} ; do i:: log && i::reset ; done
time::block "log 1" 10

time::mark
for run in {1..10} ; do i:: log ; done
time::block "log 2" 10

time::mark
for run in {1..10} ; do i:: log ; done
time::block "log 3" 10

time::command "i:: log" "" 100
time::command "i:: log" "" 1000
time::command "i::source log" "" 1000

time:: "end"
