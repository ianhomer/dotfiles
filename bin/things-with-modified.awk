#!/usr/bin/awk -f
#
# Prepend a search stream from ripgrep with last modified date for the file, where 
# filename is the first column up to the ":"
#

BEGIN { FS = ":" ; OFS = ":" }
{ cmd="stat -f '%m' "$1 ; cmd|getline ts ; print ts,$1,$2 ; close(cmd) }
