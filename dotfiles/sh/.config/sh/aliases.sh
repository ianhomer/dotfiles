# Aliases that work in all shells. fish, zsh, bash etc
alias vi="VIM_KNOB=5 nvim"
alias v="VIM_KNOB=5 nvim"
alias do="todo"

# search for file in directory and open in vi
alias o="fd | fzf | xargs nvim -c ':cd %:h'"
alias oh="fd -H | fzf | xargs nvim -c ':cd %:h'"
alias oi="fd -I | fzf | xargs nvim -c ':cd %:h'"
alias ohi="fd -HI | fzf | xargs nvim -c ':cd %:h'"



