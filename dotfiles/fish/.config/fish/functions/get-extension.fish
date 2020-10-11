function get-extension
  echo (string split -r -m1 . $argv)[2]
end
