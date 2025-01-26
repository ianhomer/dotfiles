#
# key bindings
#
# * fish_vi_key_bindings -> vi key bindings
# * fish_default_key_bindings -> default key bindings
#

function fish_user_key_bindings
  set -g fish_key_bindings fish_vi_key_bindings
  fish_default_key_bindings -M insert
  fish_vi_key_bindings --no-erase insert

  bind \cf forward-word
  bind \cb backward-word
end
