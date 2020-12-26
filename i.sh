#!/bin/bash

#
# Module loader
#

if [[ -z "${SHIM_LOADED}" ]] ; then
  echo "Please \$(shim) before sourcing i.sh"
else
  function i::reset() {
    unset loadmeLoaded
  }

  function i::() {
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

  function i::source() {
    module=$1
    filename="${DOTFILES_BIN}/functions/${module}.sh"
    . $filename
  }
fi

