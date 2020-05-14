# Cheats - vim

## vim

### misc

**space+r**
: Open (paste) registry

**space+c**
: Commits

**space+cw**
: Clear white space

**space+h**
: File open history

### maps

**space+m**
: Keyboard map for normal mode

**:Maps!**
: Open maps in full screen

**space+l**
: Keyboard map for insert mode

### files

**space+n**
: Open nerd tree 

**space+s**
: Save all files

**:NERDTreeToggle** or **space+f**
: Open file browser

**:cd**
: change directory

**space + r** or **:reg**
: show paste registry

**"2p**
: paste a previous cut

**gf**
: go to file under cursor

**gx**
: open link in browser

**gt**
: go to next tab

**tabe**
: open file in new tab

**m** + letter
: set mark

**'** + letter
: go to mark

**Ctrl+^**
: switch to previous buffer

**:tab h whatever**
: open help in a new tab

**Ctrl-w o**
: make pane the only visible one

**:noh**
: clear last highlight

**:enew | pu=execute('autocmd')**
: copy output of command, e.g. autocmd, into buffer

### buffers

**:bd**
: close buffer

**:bn**
: next buffer

**bufdo bd**
: close all buffers

**space+b**
: Commits for current buffer

**space+5**
: Close all buffers except current one

**space+space**
: Show buffers

#### NERDTree

**m**
: open file actions

**Shift+i**
: show hidden files

**U**
: Up directory

**C**
: Set root directory

**cd**
: Change current directory to current note

**CD**
: Change root directory to current directory

#### netrw

**-**
: up a directory

**i**
: change list view

**I**
: show header

**gn**
: make current node root of tree

**gh**
: hide/un-hide dot files

percent **%**
: create new file

#### motion

**0**
:beginning of line

**\$**
: end of line

**}**
: next block

**{**
: previous block

**[[**
: next header

**]]**
: previous header

**:nn**
: line nn

**gg**
: beginning of file

**GG**
: end of file

percent **%**
: next / previous bracket

**,star**
: search for word under cursor

### windows

- **:split,:vsplit** - split pane
- **80 Ctrl-w** + - set current pane to 80 characters
- **Ctrl-w+left/right** or **Ctrl-h/j/k/l** - move to another pane
- **count<leader>cc** - comment out the next count lines

### edit

**space+g**, **:Goyo**
: distraction free coding with Goyo

**gw{motion}**
: reformat content

**select+gw**
: reformat content

**select+S"**
: surround selected **area** with quotes

**ysiw"**
: surround word with quotes

**Ctrl+v**
: select visual block, e.g. column

**:%!jq .**
: reformat JSON

**:Tabularize /|** or \*\*space\*\*
: Align paragraph on character

**count+space+cc**
: comment out the next count lines

**:Format**
: Format current buffer

**space+d**
: Open CoC diagnostics

**:nu**
: Show line numbers

**:set rnu**
: Show relative line numbers

**star**
: Search for next occurence of word under cursor

**space+w**
: Clear white space at end of lines

**yaf**
: Yank all filw

### Markdown

- **viWS+** - make a word bold
- **zR** - open all folds
- **zM** - close all folds

### Selections

- **vip** - select paragraph
- **viW** - select current word (including non-alphanumeric)

### Configuration

**space+p**
: Toggle power configuration

**space+v**
: Reload vim configuration


