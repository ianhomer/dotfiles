#!/usr/bin/env bash

#
# Run with native MacOS bash with
#   /bin/bash test/scripts/profile.sh
#

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
time::command "gdate +%s%6N > /dev/null" "gdate +%s%6N" 100
time::command "time::ms > /dev/null" "time::ms" 100

time::mark
for run in {1..10} ; do . ${DOTFILES_BIN}/functions/log.sh ; done
time::block ". log.sh" 1000

time::command ". ${DOTFILES_BIN}/functions/log.sh" "command . log.sh" 1000

time::command "i::source log" "" 1000
time::command "i:: log && i::reset" "" 1000
time::command "i:: log" "" 10
time::command "i:: log" "" 100
time::command "i:: log" "" 1000

time:: "end"
