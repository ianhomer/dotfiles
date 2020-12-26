#!/bin/bash

set -e

# Experiment with function loading

$(shim) && . ${ME}/i.sh
i:: time

time::start
echo ${SHIM_OS}
time::me "start"

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

time::me "end"
