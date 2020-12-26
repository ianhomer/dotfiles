#!/bin/bash

$(shim)

loadme() {
  module=$1
  moduleLoaded="${module}_loaded"
  loaded=1#$(eval echo \${${module}_loaded})
  filename="${DOTFILES_BIN}/functions/${module}.sh"
  echo ${!moduleLoaded}
  if [ -z "${!moduleLoaded}" ]; then
    . $filename
    functions=$(grep "^function" $filename | sed 's/function \([a-z_:]*\).*/\1/')
    for function in $functions ; do
      echo "Loaded $function"
    done
    eval ${module}_loaded=1
  fi
}


