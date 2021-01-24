#!/bin/bash

#
# A module loader used by these dotfiles to import shell functions to be used
# by a script.
#
# The typical idiom for using this module loader is in scripts when run alongside
# the shim script giving us:
#
#   $(shim) && . ${ME}/i.sh
#
# which shims in the necessary environment variables and loads the module
# loader, along with the log module loaded by default.
#
# After this line is executed the log module is ready to use, e.g
#
#   log::trace "My trace message"
#
# and other modules can be loaded with, e.g loading the time module with
#
#   i:: time
#
# A module is simply a collection of shell functions which are prefixed with the
# module name.

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
