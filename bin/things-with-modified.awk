#!/usr/bin/awk -f
#
# Prepend a search stream from ripgrep with last modified date for the file, where
# filename is the first column up to the ":"
#
# Note that the python script things-with-modified proved to more efficient than
# this since the repetive system calls to stat is expensive (e.g. took 500ms for
# 1000 rows as opposed to 10ms with python).

BEGIN { FS = ":" ; OFS = ":" }
{ cmd="stat -f '%m' "$1 ; cmd|getline ts ; print (10000000000-ts "-" 10000+$2),$0 }
