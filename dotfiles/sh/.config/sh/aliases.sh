# Aliases that work in all shells. fish, zsh, bash etc
alias vi="VIM_KNOBS=5 nvim"
alias v="VIM_KNOBS=5 vim"

alias q="exit"
alias push="git push"
alias gs="git status"
alias gd="git diff HEAD"
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="ls --color=auto"

# Things
alias d="todo"
alias t="thing"
alias ts="things"
alias s="things-sync"
alias sc="things-sync -c"

# Attach to tmux session if exists, otherwise new
alias tm="tmux attach || tmux new"

# Start kitty base
alias kit="kitty --single-instance --session ~/.config/kitty/base.conf& ; disown ; exit"

# search for file in directory and open in vi
alias o="fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias oh="fd -H | fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias oi="fd -I | fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias ohi="fd -HI | fzf --height "100%" | xargs nvim -c ':cd %:h'"



