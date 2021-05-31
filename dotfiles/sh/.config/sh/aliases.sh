# Aliases that work in all shells. fish, zsh, bash etc
alias vi="VIM_KNOB=5 nvim"
alias v="VIM_KNOB=5 vim"

alias q="exit"
alias push="git push"
alias gs="git status"
alias gd="git diff HEAD"

# Things
alias d="do"
alias t="thing"
alias ts="things"

# Attach to tmux session if exists, otherwise new
alias tm="tmux attach || tmux new"

# search for file in directory and open in vi
alias o="fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias oh="fd -H | fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias oi="fd -I | fzf --height "100%" | xargs nvim -c ':cd %:h'"
alias ohi="fd -HI | fzf --height "100%" | xargs nvim -c ':cd %:h'"



