# tmux cheats

## tmux

### modifier

|          |        |
| -------- | ------ |
| `Ctrl+a` | prefix |

### sessions

|               |                     |
| ------------- | ------------------- |
| `Ctrl+a+$`    | rename session      |
| `Ctrl+a+s`    | choose session      |
| `Ctrl+a+d`    | detach from session |
| `Ctrl+a :new` | create new session  |

### windows

|                     |                                        |
| ------------------- | -------------------------------------- |
| `Ctrl+a+c`          | new window                             |
| `Ctrl+a+w`          | show windows                           |
| `Ctrl+a+,`          | rename window                          |
| `Alt+arrow`         | move to window left or right           |
| `Shift+Alt+arrow`   | move window left or right in tab order |
| `Ctrl+a+Ctrl+arrow` | resize window in direction             |

### panes

|              |                                                  |
| ------------ | ------------------------------------------------ |
| `Ctrl+a+z`   | zoom in / out of current pane                    |
| `Ctrl+a+\`   | split pane right                                 |
| `Ctrl+a+-`   | split pane below                                 |
| `Ctrl+a+x`   | close pane                                       |
| `Ctrl+hjkl`  | move between panes ; including through vim panes |
| `Ctrl+arrow` | move between panes ; including through vim panes |
| `Ctrl+a+{`   | move pane left                                   |
| `Ctrl+a+}`   | move pane right                                  |

### maps

|            |               |
| ---------- | ------------- |
| `Ctrl+a+?` | show bindings |

### edit

|            |                                           |
| ---------- | ----------------------------------------- |
| `Ctrl+a+[` | vi copy mode with enter to copy selection |
| `Ctrl+a+]` | paste from buffer                         |

### misc

|                            |                           |
| -------------------------- | ------------------------- |
| `Ctrl+a+t`                 | show time                 |
| `Ctrl+a+r`                 | reload tmux configuration |
| `Ctrl+a+Ctrl+r`            | reload tmux state         |
| `Ctrl+a+space`             | toggle between layouts    |
| `tmux ls`                  | list sessions             |
| `tmux attach -tmy-session` | attach to session         |
| `Ctrl+a+b`                 | toggle status bottom bar  |

hold option + mouse
: bypass tmux mouse handling and do iterm action

click command click
: block select

### links

[more tmux cheats](https://tmuxcheatsheet.com/)
