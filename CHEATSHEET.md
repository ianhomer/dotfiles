# Cheatsheet

Useful keyboard short cuts.

## OSX

**Ctrl+Up**
: Mission Control / space management

**Ctrl-right/left**
: Move to other spaces

**Ctrl+Cmd+click+drag**
: Move Window

**Ctrl+Cmd+space**
: Open special character window

**Cmd+Tab**
: Switch windows

**Cmd+h**
: Hide window

**Cmd+c**
: Copy

**Cmd+v**
: Paste

**Cmd+z**
: Undo

**Cmd+Shift+.** - in finder window
: Show hidden files

## Todoist

**Ctrl-Cmd+a**
: Create task

**Ctrl-Cmd-t**
: Open up tasks list

## Magnet

**Ctrl-Alt+return**
: Full screen

**Ctrl-Alt-left,right,up,down**
: Half screen

**Ctrl-Alt-uijk**
: Quarter screen

**Ctrl-Alt-deftg**
: Thirds

**Ctrl-Cmd-back**
: Back to manually set screen size

## Brave

**Cmd+l**
: Jump to address bar

**Option+Cmd** left/right
: Go to previous/next tab

**Cmd+w**
: Close tab

**Option+Cmd b**
: Open bookmarks

## iterm

**Cmd+n**
: New terminal window

**git open**
: Open git repository in web browser

**z my-dir <tab>**
: find recently opened folder (using fasd)

**z**
: list recently opened folder we

## tmux

**Ctrl-a**
: prefix

prefix **c**
: new window

prefix **w**
: show windows

prefix **,**
: rename window

prefix **\$**
: rename session

prefix **|** or **-**
: split pane

prefix **x**
: close pane

**prefix s**
: choose session

prefix **t**
: show time

prefix **z**
: zoom in / out of current pane

prefix **d**
: detach from session

**Opt-arrow**
: move between panes

**prefix Ctrl-s**
: save tmux state

**prefix Ctrl-r**
: reload tmux state

**Ctrl-hjkl**
: move between panes including through vim panes

**Ctrl-arrow**
: move between panes including through vim panes

**Ctrl-Shift-arrow**
: move window left or right in tab order

prefix **space**
: toggle between layouts

prefix **[**
: copy mode with **Enter** to copy selection

prefix **{}**
: move pane left / right

hold option + mouse
: bypass tmux mouse handling and do iterm action

click command click
: block select

[more tmux cheats](https://tmuxcheatsheet.com/)

from outside tmux

**tmux ls**
: list sessions

**tmux attach -t my-session**
: attach to session

## git

- git-set-personal-url - set the repository to push with personal credentials

## fish

- **Ctrl-a Ctrl-a** - beginning of line
- **Ctrl-e** - end of line
- **Ctrl-b** - back a word
- **Ctrl-f** - forward a word
- **bind** - see key bindings

## vi

### vi - Files, Buffers & Navigations

- **:NERDTreeToggle** or **space+f** - Open file browser
  - **m** - open file actions
  - **Shift+i** - show hidden files
- **:cd** - change directory
- **space + r** or **:reg** - show paste buffer
- **:bd** - close buffer
- **:bn** - next buffer
- **"2p** - paste a previous cut
- **gf** - go to file under cursor
- **gx** - open link in browser
- **gt** - go to next tab
- **tabe** - open file in new tab
- **bufdo bd** - close all buffers
- **m** + letter - set mark
- **'** + letter - go to mark
- **Ctrl-^** - switch to previous buffer
- **:tab h whatever** - open help in a new tab
- **Ctrl-w o** - make pane the only visible one
- **:noh** - clear last highlight
- **:enew|pu=execute('autocmd')** - copy output of command, e.g. autocmd, into
  buffer

#### netrw

- **-** - up a directory
- **i** - change list view
- **I** - show header
- **gn** - make current node root of tree
- **gh** - hide/un-hide dot files
- **%** - create new file

#### Go to

- **0** - beginning of line
- **\$** - end of line
- **}** - next block
- **{** - previous block
- **[[** - next header
- **]]** - previous header
- **:nn** - line nn
- **gg** - beginning of file
- **GG** - end of file
- **%** - next / previous bracket

### vi - Window Management

- **:split,:vsplit** - split pane
- **80 Ctrl-w** + - set current pane to 80 characters
- **Ctrl-w+left/right** or **Ctrl-h/j/k/l** - move to another pane
- **count<leader>cc** - comment out the next count lines

### vi - Editing

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

## Document conversions

- **pandoc README.md -s -o ~/tmp/test.pdf** - convert markdown file to PDF

## Gmail

[gmail keyboard shortcuts](https://support.google.com/mail/answer/6594) :

- **Shift-?** - keyboard shortcuts
- **,** - move focus
- **e** - archive message
- **s** - star message
