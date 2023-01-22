# Vim Cheats

## vim

### memento

Shortcuts I'm trying to remember.

|           |                                                       |
| --------- | ----------------------------------------------------- |
| `gd`      | Go to definition                                      |
| `ctrl-]`  | Go to tag                                             |
| `ctrl-o`  | Jump back to previous location (after `gd` or `ctr-]` |
| `space-e` | Show LSP diagnostics on current line                  |
| `[-d`     | Previous LSP diagnostic                               |
| `]-d`     | Next LSP diagnostic                                   |
| `space-7  | Show trouble                                          |
| `ctrl-X`  | In FZF open in horizontal split                       |
| `%norm`   | Do operation on each line in file                     |
| `csw"`    | Quote word                                            |
| `:xa`     | Save all and exit                                     |

### motion

|             |                                                 |
| ----------- | ----------------------------------------------- |
| `0`         | Beginning of line                               |
| `$`         | End of line                                     |
| `}`         | Next block                                      |
| `{`         | Previous block                                  |
| `[[`        | Next header                                     |
| `]]`        | Previous header                                 |
| `:nn`       | Line nn                                         |
| `gd`        | Go to definition                                |
| `gg`        | Beginning of file                               |
| `GG`        | End of file                                     |
| `gx`        | Open URL                                        |
| `percent %` | Next / previous bracket                         |
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

### cmdline

command-line-mode

|                    |                     |
| ------------------ | ------------------- |
| `ctrl-b`           | Beginning of line   |
| `ctrl-e`           | End of line         |
| `ctrl-shift-arrow` | Left or right word  |
| `ctrl-f`           | Command line window |

### cmdwin

command-line-window

|      |                          |
| ---- | ------------------------ |
| `q:` | Open command-line window |

### telescope

|          |                         |
| -------- | ----------------------- |
| `ctrl-/` | Show telescope mappings |

### debug

Start a process in debug mode, e.g. `--inspect-brk` in node. Then use the `,`
shortcuts for run and debug features.

|      |                                   |
| ---- | --------------------------------- |
| `,t` | Toggle a break point              |
| `,c` | Attach to debugger or continue    |
| `,o` | Open debugger UI                  |
| `,p` | Hover window for current variable |

### misc

|            |                   |
| ---------- | ----------------- |
| `space+c`  | Commits           |
| `space+cw` | Clear white space |
| `space+h`  | File open history |

### maps

|             |                              |
| ----------- | ---------------------------- |
| `space+m`   | Keyboard map for normal mode |
| `:Maps!`    | Open maps in full screen     |
| `space+l`   | Keyboard map for insert mode |
| `:dig`      | List di-graphs               |
| `ctrl-k Co` | Insert di-graph e.g. ©       |

### registers

|                        |                                              |
| ---------------------- | -------------------------------------------- |
| `"`                    | Show registers                               |
| `ctrl-r`               | Select register in insert mode and Telescope |
| `call setreg('a', [])` | Clear a register                             |
| `"add`                 | Delete line into register a                  |
| `"ap`                  | Paste line from register a                   |
| `space + r` or `:reg`  | Show paste register                          |

### files

|              |                           |
| ------------ | ------------------------- |
| `space+n`    | Open file explorer        |
| `space+s`    | Save all files            |
| `space+f`    | Open file browser         |
| `:cd`        | Change directory          |
| `"2p`        | Paste a previous cut      |
| `gf`         | Go to file under cursor   |
| `gx`         | Open link in browser      |
| `gt`         | Go to next tab            |
| `tabe`       | Open file in new tab      |
| `m + letter` | Set mark                  |
| `' + letter` | Go to mark                |
| `Ctrl+^`     | Switch to previous buffer |
| `:tab h foo` | Open help in a new tab    |
| `Ctrl+w o`   | Make pane the visible one |
| `:noh`       | Clear last highlight      |

`:enew | pu=execute('autocmd')`
: copy output of command, e.g. autocmd, into buffer

### buffers

|               |                            |
| ------------- | -------------------------- |
| `:bd`         | Close buffer               |
| `:bn`         | Next buffer                |
| `bufdo bd`    | Close all buffers          |
| `space+b`     | Commits for current buffer |
| `space+space` | Show buffers               |

### windows

|                 |                                   |
| --------------- | --------------------------------- |
| `:split`        | Split pane                        |
| `:vsplit`       | Split pan vertically              |
| `80 Ctrl+w`     | Set current pane to 80 characters |
| `Ctrl+w Ctrl+=` | Even out the windows              |

### edit

|                  |                                        |
| ---------------- | -------------------------------------- |
| `space+g`        | Distraction free coding with Goyo      |
| `gw{motion}`     | Reformat content                       |
| `select+gw`      | Reformat content                       |
| `select+S"`      | Surround selected **area** with quotes |
| `ysiW"`          | Surround word with quotes              |
| `ysiWb`          | Surround double star - bold            |
| `visual+S`       | surround visual selection              |
| `Ctrl+v`         | Select visual block, e.g. column       |
| `:%!jq .`        | Reformat JSON                          |
| `count+space+cc` | Comment out the next count lines       |
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

|       |                                                 |
| ----- | ----------------------------------------------- |
| `=`   | Show diff for selected file                     |
| `-`   | Stage of selected file (toggle)                 |
| `-`   | Push current commit or HEAD if on unpushed line |
| `s`   | Stage selected file                             |
| `X`   | Discard changes on selected file                |
| `cc`  | Commit staged files                             |
| `cw`  | Change commit message for selected commit       |
| `gq`  | Quit fugitive window                            |
| `gpa` | Go to unpushed and push                         |

### Quickfix

|      |                |
| ---- | -------------- |
| `]q` | Next quick fix |

### Markdown

|             |                  |
| ----------- | ---------------- |
| `viWS+`     | Make a word bold |
| `zR`        | Open all folds   |
| `zM`        | Close all folds  |
| `<space>+l` | Lint file        |

### Selections

|       |                                                  |
| ----- | ------------------------------------------------ |
| `vip` | Select paragraph                                 |
| `viW` | Select current word (including non-alphanumeric) |

### Configuration

|           |                            |
| --------- | -------------------------- |
| `space+p` | Toggle power configuration |
| `space+v` | Reload vim configuration   |

### fzf

|          |                           |
| -------- | ------------------------- |
| `Ctrl+x` | Open in horizontal split  |
| `Ctrl+v` | Open in vertical split    |
| `Ctrl+/` | Toggle preview window off |

### tricks

|     |            |
| --- | ---------- |
| ``  | Vim tricks |
