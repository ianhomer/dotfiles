#!/usr/bin/env bash

#
# Run with native MacOS bash with
#
#   /bin/bash test/scripts/profile.sh
#

set -e

# Experiment with function loading

$(shim) && cd ${ME} && . bin/i.sh
i:: time

log:: "profile"

time::start
time:: "start"

time::mark
for run in {1..10000} ; do : ; done
time::block "control 10000" 10000
time::command ":" "command 100" 100
time::command ":" "command 1000" 1000
time::command ":" "command 10000" 10000
time::command "sleep 0.001" "" 50
time::command "gdate +%s%6N" "" 100
time::command "echo ${EPOCHREALTIME}" "echo EPOCHREALTIME" 100
time::command "time::ms" "" 100

time::mark
for run in {1..1000} ; do . ${DOTFILES_BIN}/functions/log.sh ; done
time::block ". log.sh" 1000

time::command ". ${DOTFILES_BIN}/functions/log.sh" "command . log.sh" 1000

fun() { . ${DOTFILES_BIN}/functions/log.sh ; }
time::function fun "function . log.sh" 1000

time::command "i::source log" "" 1000
time::command "i:: log" "" 10
time::command "i:: log" "" 100
time::command "i:: log" "" 1000
time::command "i:: log" "" 10000

time:: "end"
