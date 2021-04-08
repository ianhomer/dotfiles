#!/usr/bin/env bash

set -x
time VIM_KNOB=0 nvim --noplugin -u NONE +q
time VIM_KNOB=0 nvim --noplugin +q
time VIM_KNOB=0 nvim +q
set +x

echo "KNOB 1"
time VIM_KNOB=1 nvim +q
echo "KNOB 2"
time VIM_KNOB=2 nvim +q
echo "KNOB 3"
time VIM_KNOB=3 nvim +q
echo "KNOB 4"
time VIM_KNOB=4 nvim +q
echo "KNOB 5"
time VIM_KNOB=5 nvim +q


