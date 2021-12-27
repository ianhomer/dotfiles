git clone https://aur.archlinux.org/neovim-nightly-bin.git
cd neovim-nightly-bin
makepkg -si

echo "{}" > test.jsonc
nvim --clean test.jsonc +"filetype plugin on" \
  +"doautocmd BufRead" +"doautocmd BufRead" +":q!" --headless
vim --clean test.jsonc +"filetype plugin on" +"do BufRead" +"do BufRead"

echo "{}" > test.json
nvim --clean test.json +"filetype plugin on" +"syntax on" \
  +"do BufRead" +"do BufRead" +":q!" --headless



nvim --clean test.jsonc +"filetype plugin on"
nvim --clean test.jsonc +"syntax on"
nvim --clean test.jsonc +"filetype plugin on" +"syntax on"


--startuptime ~/start-clean.log



nvim --clean test.jsonc +"filetype plugin on" +"syntax on" \
  +"doautocmd BufRead" --startuptime ~/start-clean.log


