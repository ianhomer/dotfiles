# Aliases that work in all shells. fish, zsh, bash etc
alias vi="VIM_KNOB=5 nvim"
alias v="VIM_KNOB=5 nvim"
alias do="todo"

alias d="docker"
alias push="git push"
alias gs="git status"
alias gd~="git diff HEAD~"

# Attach to tmux session if exists, otherwise new
alias tm="tmux attach || tmux new"

# search for file in directory and open in vi
alias o="fzf | xargs nvim -c ':cd %:h'"
alias oh="fd -H | fzf | xargs nvim -c ':cd %:h'"
alias oi="fd -I | fzf | xargs nvim -c ':cd %:h'"
alias ohi="fd -HI | fzf | xargs nvim -c ':cd %:h'"



