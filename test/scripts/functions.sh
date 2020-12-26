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
for run in {1..10} ; do
  . ${DOTFILES_BIN}/functions/log.sh
done
time::block "loading log function" 10

. ${DOTFILES_BIN}/functions/loadme.sh
time::me "loader loaded"
time::mark
loadme log
time::block "log 1"
time::mark
loadme log
time::block "log 2"
time::mark
loadme log
time::block "log 3"
time::me "end"
