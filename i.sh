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
  
  function o_trace() {
    if [[ "$TRACEME" == "y" ]] ; then
      printf "... \e[38;5;238m$*\e[0m\n"
    fi
    return 0
  }

  function i::() {
    modules=$*
    for module in $modules ; do
      filename="${DOTFILES_BIN}/functions/${module}.sh"
      if ! [[ "${loadmeLoaded}" =~ ":$module:" ]]; then
        o_trace "Sourcing $filename"
        . $filename
        functions=$(grep "^function" $filename | sed 's/function \([a-z_:]*\).*/\1/')
        for function in $functions ; do
          o_trace "Exporting $function"
          export -f $function
        done
        export loadmeLoaded="${loadmeLoaded}:${module}:"
      else
        o_trace "Module $module already loaded"
      fi
    done
  }

  function i::source() {
    module=$1
    filename="${DOTFILES_BIN}/functions/${module}.sh"
    . $filename
  }
fi

i:: log
