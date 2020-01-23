# Cheatsheet

Useful keyboard short cuts.

# OSX

* **Ctrl+Up** - Mission Control / space management
  * **Ctrl-right/left** - Move to other spaces
* **Ctrl+Cmd+click+drag** - Move Window
* **Ctrl+Cmd+space** - Open special character window

# iterm

* **Cmd+n** - New terminal window
* **git open** - Open git repository in web browser
* **z mydir <tab>** - find recently opened folder (using fasd)
* **z** - list recently opened folder weightings

# tmux

* **Ctrl-a** - prefix
* prefix **c** - new window
* prefix **w** - show windows
* prefix **,** - renmae window
* prefix **|** or **-** - split pane
* prefix **x** - close pane
* prefix **t** - show time
* **Opt-arrow** - move between panes
* prefix **space** - toggle between layouts
* prefix **[** - copy mode with **Enter** to copy selection

[more tmux cheats](https://tmuxcheatsheet.com/)

# vi

## vi - Files, Buffers & Navigations

* **:NERDTreeToggle** or **<F7>** - Open file browser
  * **m** - open file actions
  * **Shift+i** - show hidden files
* **:cd** - change directory
* **:reg** - show paste buffer
* **:bd** - close buffer
* **:bn** - next buffer
* **"2p** - paste a previous cut
* **gf** - go to file under cursor
* **gx** - open link in browser
* **gt** - go to next tab
* **tabe** - open file in new tab
* **bufdo bd** - close all buffers

## vi - Window Management

* **:split,:vsplit** - split pane
* **80 Ctrl-w** + - set current pane to 80 characters
* **Ctrl-w+left/right** or **Ctrl-h/j/k/l** - move to another pane

## vi - Editing

* **:Goyo** - distraction free coding
* **gw{motion}** - reformat content
* **select+gw** - reformat content
* **select+S"** - surround selected **area** with quotes
* **ysiw"** - surround word with quotes

## vi - Markdown

* **viWS+** - make a word bold
* **zR** - open all folds
* **zM** - close all folds

## vi - Selections

* **vip** - select paragraph
* **viW** - select current word (including non-alphanumeric)
* hold option + mouse - bypass tmux mouse handling and do iterm action
* click option click - block select
