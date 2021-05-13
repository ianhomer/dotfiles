#!/usr/bin/awk -f
#
# Prepend a search stream from ripgrep with last modified date for the file, where filename is the first column up to
# the ":"
#

BEGIN { FS = ":" }
{ "stat -f '%m' " $1 | getline ts ; print ts ":" $1 ":" $2 }
