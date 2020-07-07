# Open file in appropriate tool
function open
  if [ -n "$argv" ]
    set filename $argv
  else
    set filename (fzf --preview 'bat {-1} --color=always')
  end

  if [ -n "$filename" ]
    set extension (get-extension $filename)
    if string match -qr "^http(s)?://.*" $filename
      /usr/bin/open $filename
    else if test "$extension" = "svg"
      /usr/bin/open -a /Applications/draw.io.app/ $filename
    else if test (file -b --mime-encoding $filename) = "binary"
      /usr/bin/open $filename
    else
      vi $filename
    end
  end
end
