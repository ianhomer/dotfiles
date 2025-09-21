# https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Zsh

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
NEWLINE=$'\n'
PROMPT='%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f $NEWLINE> '
zstyle ':vcs_info:git:*' formats '%b'
