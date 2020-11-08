function join-array () {
  separator=$1
  shift
  for thing in $@ ; do
    [[ -z "$joinOut" ]] && joinOut="" || joinOut+="$separator"
    joinOut+="$thing"
  done
  echo "$joinOut"
}
