[ {$DOT_SKIP} -eq 2 ]; and exit
[ {$DOT_ALIASES} -eq 0 ]; and exit
set -q DOT_ALIASES_LOADED; or set DOT_ALIASES_LOADED 0
[ {$DOT_ALIASES_LOADED} -eq 1 ]; and exit

# Shortcuts
if type which-dotme-aliases 2>/dev/null
  echo "‼︎ dotme aliases have already been defined"
  which-dotme-aliases
else
  alias which-dotme-aliases="echo '~/.config/fish/aliases.fish'"

  . ~/.config/sh/aliases.sh

  alias do="todo"
  alias ls="exa"

  # git
  alias branch="git branch"
  alias checkout="git checkout"
  alias branch-and-checkout="git checkout -b"
  alias g="git"
  alias git-commit-am="git commit -am"
  alias gsv="git status -v"
  alias gits="git status"
  alias gds="git diff --staged"
  alias gdc="git diff --cached"
  alias git-diff="git diff"
  alias git-diff-head~="git diff HEAD~"
  alias gita="git add"
  alias gitc="git commit"
  # count changes - thx https://preslav.me/2020/03/01/use-the-git-history/
  alias git-count="git log --format=format: --name-only | egrep -v '^\$' | sort | uniq -c | sort -rg | head -10"

  alias git-whoami="git config user.name ; git config user.email"
  alias git-config-personal="git config user.email ian@purplepip.com"

  alias draw="/usr/bin/open -a /Applications/draw.io.app/"

  alias lastpass="lpass show --password -c"
  alias lastpasses="lpass ls"

  alias findmd="find . -type f -name '*.md' -not -path '*/node_modules/*' | sort"
  # cat markdown files with a space between each
  alias catmd="findmd | xargs awk '(NR>1 && FNR==1){printf (\"\n\")};1'"

  alias b='buku --suggest'

  alias fck="fuck"
  alias nnn="nnn -e"

  [ {$DOT_LOG_LEVEL} -gt 1 ] ;and \
    echo "◎ loaded ~/.config/fish/aliases.fish"

  set DOT_ALIASES_LOADED 1
end
