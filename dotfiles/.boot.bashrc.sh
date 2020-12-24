#
# bashrc that boots up dotfiles on start
#
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '
echo "dotme boot bashrc"
if [[ ! -f "$HOME/.config/dotme/.shim" ]] ; then
  echo "auto booting dotme"
  rm ~/.bashrc
  rm ~/.bash_profile
  $HOME/.dotfiles/start
  . ~/.bash_profile
  . ~/.bashrc
fi
