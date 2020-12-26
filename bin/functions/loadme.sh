#!/bin/bash

$(shim)

loadme::reset() {
  unset loadmeLoaded
}

loadme() {
  module=$1
  filename="${DOTFILES_BIN}/functions/${module}.sh"
  if ! [[ "${loadmeLoaded}" =~ ":$module:" ]]; then
    . $filename
    #functions=$(grep "^function" $filename | sed 's/function \([a-z_:]*\).*/\1/')
    #for function in $functions ; do
    #  echo "Loaded $function"
    #done
    export loadmeLoaded="${loadmeLoaded}:${module}:"
  fi
}


