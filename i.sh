#!/bin/bash

#
# Module loader
#

if [[ -z "${SHIM_LOADED}" ]] ; then
  echo "Please \$(shim) before sourcing i.sh"
else
  if ! command -v i:: &>/dev/null ; then
    function log::trace() {
      if [[ "$TRACEME" == "y" ]] ; then
        printf "... \e[38;5;238m$*\e[0m\n"
      fi
      return 0
    }

    # Import module
    function i::() {
      _modules=$*
      for module in $_modules ; do
        filename="${DOTFILES_BIN}/functions/${module}.sh"
        if ! command -v "${module}::" &>/dev/null ; then
          log::trace "Sourcing $filename"
          . $filename
          if [[ -n "$BASH" ]] ; then
            functions=$(grep "^function" $filename | sed 's/function \([a-z_:]*\).*/\1/')
            for function in $functions ; do
              log::trace "Exporting $function"
              export -f $function
            done
          fi
        else
          log::trace "Module $module already loaded"
        fi
      done
    }

    function i::source() {
      module=$1
      filename="${DOTFILES_BIN}/functions/${module}.sh"
      . $filename
    }

    if [[ -n "$BASH" ]] ; then
      export -f i::
    fi
    i:: log
  else
    log::trace "i.sh already loaded"
  fi
fi
