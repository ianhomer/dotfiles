#
# Things functions
#

if [[ "$OSTYPE" =~ ^linux-android ]]; then
  THINGS=/storage/emulated/0/projects/things
else
  THINGS=$HOME/projects/things
fi
