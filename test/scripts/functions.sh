#!/bin/bash

set -e

# Experiment with function loading

start=`gdate +%s%N`

$(shim)
. ${DOTFILES_BIN}/functions/time.sh
time::start
echo ${SHIM_OS}
time::me "start"

time::mark
for run in {1..10} ; do . ${DOTFILES_BIN}/functions/log.sh ; done
time::block "loading log function" 10

. ${DOTFILES_BIN}/functions/loadme.sh
time::me "loader loaded"

time::mark
for run in {1..10} ; do loadme log && loadme::reset ; done
time::block "log 1"

time::mark
for run in {1..10} ; do loadme log ; done
time::block "log 2" 10

time::mark
for run in {1..10} ; do loadme log ; done
time::block "log 3" 10

time::me "end"
