# Cheats - vim

## vi

### vi - files

**:NERDTreeToggle** or **space+f**
: Open file browser

**:cd**
: change directory

**space + r** or **:reg**
: show paste buffer

**:bd**
: close buffer

**:bn**
: next buffer

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

**bufdo bd**
: close all buffers

**m** + letter
: set mark

**'** + letter
: go to mark

**Ctrl-^**
: switch to previous buffer

**:tab h whatever**
: open help in a new tab

**Ctrl-w o**
: make pane the only visible one

**:noh**
: clear last highlight

**:enew|pu=execute('autocmd')**
: copy output of command, e.g. autocmd, into buffer

#### vi - NERDTree

**m**
: open file actions

**Shift+i**
: show hidden files

#### vi - netrw

- **-** - up a directory
- **i** - change list view
- **I** - show header
- **gn** - make current node root of tree
- **gh** - hide/un-hide dot files
- **%** - create new file

#### vi - navigation

- **0**- beginning of line
- **\$** - end of line
- **}** - next block
- **{** - previous block
- **[[** - next header
- **]]** - previous header
- **:nn** - line nn
- **gg** - beginning of file
- **GG** - end of file
- **%** - next / previous bracket

### vi - windows

- **:split,:vsplit** - split pane
- **80 Ctrl-w** + - set current pane to 80 characters
- **Ctrl-w+left/right** or **Ctrl-h/j/k/l** - move to another pane
- **count<leader>cc** - comment out the next count lines

### vi - editing

:**:Goyo**
: distraction free coding

**gw{motion}**
: reformat content

**select+gw**
: reformat content

**select+S"**
: surround selected **area** with quotes

**ysiw"**
: surround word with quotes

**Ctrl-v**
: select visual block, e.g. column

**:%!jq .**
: reformat JSON

**:Tabularize /|** or \*\*space\*\*
: Align paragraph on character

**count<leader>cc**
: comment out the next count lines

**:Format**
: Format current buffer

**<leader>d**
: Open CoC diagnostics

### vi - Markdown

- **viWS+** - make a word bold
- **zR** - open all folds
- **zM** - close all folds

### vi - Selections

- **vip** - select paragraph
- **viW** - select current word (including non-alphanumeric)

