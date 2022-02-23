# Vim Cheats

## vim

### memento

Shortcuts I'm trying to remember.

|           |                                                       |
| --------- | ----------------------------------------------------- |
| `gd`      | Go to definition                                      |
| `ctrl-]`  | Go to tag                                             |
| `ctrl-o`  | Jump back to previous location (after `gd` or `ctr-]` |
| `space-d` | Show LSP diagnostics on current line                  |
| `[-d`     | Previous LSP diagnostic                               |
| `]-d`     | Next LSP diagnostic                                   |
| `ctrl-X`  | In FZF open in horizontal split                       |
| `%norm`   | Do operation on each line in file                     |
| `csw"`    | Quote word                                            |
| `:xa`     | Save all and exit                                     |

### telescope

|          |                        |
| -------- | ---------------------- |
| `ctrl-/` | show telescope mappngs |

### debug

Start a process in debug mode, e.g. `--inspect-brk` in node. Then use the `,`
shortcuts for run and debug features.

|      |                                   |
| ---- | ------------------------------    |
| `,t` | toggle a break point              |
| `,c` | attach to debugger or continue    |
| `,o` | open debugger UI                  |
| `,p` | hover window for current variable |

### misc

|            |                       |
| ---------- | --------------------- |
| `space+r`  | Open (paste) registry |
| `space+c`  | Commits               |
| `space+cw` | Clear white space     |
| `space+h`  | File open history     |

### maps

|            |                              |
| ---------- | ---------------------------- |
| `space+m`  | Keyboard map for normal mode |
| `:Maps!`   | Open maps in full screen     |
| `space+l`  | Keyboard map for insert mode |
| `:dig`     | List di-graphs               |
| `ctrl-k Co | Insert di-graph e.g. ©       |

### files

|                       |                             |
| --------------------- | --------------------------- |
| `space+n`             | Open nerd tree              |
| `space+s`             | Save all files              |
| `space+f`             | Open file browser           |
| `:cd`                 | change directory            |
| `space + r` or `:reg` | show paste registry         |
| `"2p`                 | paste a previous cut        |
| `gf`                  | go to file under cursor     |
| `gx`                  | open link in browser        |
| `gt`                  | go to next tab              |
| `tabe`                | open file in new tab        |
| `m + letter`          | set mark                    |
| `' + letter`          | go to mark                  |
| `Ctrl+^`              | switch to previous buffer   |
| `:tab h foo`          | open help in a new tab      |
| `Ctrl+w o`            | make pane the visible one   |
| `:noh`                | clear last highlight        |
| `"add`                | Delete line into registry a |
| `"ap`                 | Paste line from registry a  |

`:enew | pu=execute('autocmd')`
: copy output of command, e.g. autocmd, into buffer

### buffers

|               |                                      |
| ------------- | ------------------------------------ |
| `:bd`         | close buffer                         |
| `:bn`         | next buffer                          |
| `bufdo bd`    | close all buffers                    |
| `space+b`     | Commits for current buffer           |
| `space+o`     | Close all buffers except current one |
| `space+space` | Show buffers                         |

### NERDTree

|           |                                            |
| --------- | ------------------------------------------ |
| `m`       | open file action                           |
| `Shift+i` | show hidden files                          |
| `Shift+r` | reload node                                |
| `U`       | Up directory                               |
| `C`       | Set root directory                         |
| `cd`      | Change current directory to current note   |
| `CD`      | Change root directory to current directory |

### motion

|             |                                                 |
| ----------- | ----------------------------------------------- |
| `0`         | beginning of line                               |
| `\$`        | end of line                                     |
| `}`         | next block                                      |
| `{`         | previous block                                  |
| `[[`        | next header                                     |
| `]]`        | previous header                                 |
| `:nn`       | line nn                                         |
| `gd`        | go to definition                                |
| `gg`        | beginning of file                               |
| `GG`        | end of file                                     |
| `percent %` | next / previous bracket                         |
| `*`         | Search for next occurrence of word under cursor |
| `Ctrl+o`    | Jump to previous cursor position (jumplist)     |
| `Ctrl+i`    | Jump to next cursor position (jumplist)         |
| `Ctrl+u`    | Scroll up                                       |
| `Ctrl+d`    | Scroll down                                     |
| `zz`        | Scroll window center current line               |
| `zt`        | Scroll down with current line at top            |
| `zb`        | Scroll up with current line at bottom           |
| `Ctrl+]`    | Go to tag definition                            |
| `Ctrl+t`    | Go back up call stack                           |

### windows

|                 |                                   |
| --------------- | --------------------------------- |
| `:split`        | split pane                        |
| `:vsplit`       | split pan vertically              |
| `80 Ctrl+w`     | set current pane to 80 characters |
| `Ctrl+w Ctrl+=` | even out the windows              |

### edit

|                  |                                        |
| ---------------- | -------------------------------------- |
| `space+g`        | distraction free coding with Goyo      |
| `gw{motion}`     | reformat content                       |
| `select+gw`      | reformat content                       |
| `select+S"`      | surround selected **area** with quotes |
| `ysiW"`          | surround word with quotes              |
| `ysiWb`          | surround double star - bold            |
| `visual+S`       | surround visual selection              |
| `Ctrl+v`         | select visual block, e.g. column       |
| `:%!jq .`        | reformat JSON                          |
| `count+space+cc` | comment out the next count lines       |
| `:Format`        | Format current buffer                  |
| `:nu`            | Show line numbers                      |
| `:set rnu`       | Show relative line numbers             |
| `space+w`        | Clear white space at end of lines      |
| `yaf`            | Yank all file                          |

**:Tabularize /|** or \*\*space\*\*
: Align paragraph on character

### insert mode

|                 |                      |
| --------------- | -------------------- |
| `Ctrl+x+Ctrl+f` | File name completion |
| `Ctrl+[`        | Exit insert mode     |

### Spell

|          |                                           |
| -------- | ----------------------------------------- |
| `zg`     | Add word to dictionary                    |
| `2zg`    | Add word to second dictionary             |
| `z=`     | Show spell options                        |
| `Ctrl+n` | In insert mode, complete options previous |
| `Ctrl+p` | In insert mode, complete options next     |

### Git

|            |                                        |
| ---------- | -------------------------------------- |
| `:G`       | Fugitive status window (or refresh it) |
| `:Gwrite`  | Git add current file                   |
| `:Gcommit` | Git commit staged                      |
| `:Gpush`   | Git push                               |
| `:Gcd`     | Change CWD to git root                 |

### Fugitive

| | |
| -----
