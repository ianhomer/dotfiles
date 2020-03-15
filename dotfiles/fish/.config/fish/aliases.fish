# Shortcuts

if type which-dotme-aliases 2>/dev/null
  echo "... WARN : dotme aliases have already been defined"
  which-dotme-aliases
else
  alias which-dotme-aliases="echo '~/.config/fish/aliases.fish'"
  alias vi="nvim"

  # git
  alias master="git checkout master"
  alias push="git push"
  alias pull="git pull"
  alias g="git"
  alias git-commit-am="git commit -am"
  alias gs="git status"
  alias gits="git status"
  alias gd="git diff"
  alias git-diff="git diff"
  alias git-diff-head~="git diff HEAD~"
  alias gd~="git diff HEAD~"
  alias gita="git add"
  alias gitc="git commit"
  # count changes - thx https://preslav.me/2020/03/01/use-the-git-history/
  alias git-count="git log --format=format: --name-only | egrep -v '^\$' | sort | uniq -c | sort -rg | head -10"

  alias git-whoami="git config user.name ; git config user.email"
  alias git-config-personal="git config user.email ian@purplepip.com"

  # tmux
  alias t="tmux"
  alias ta="t a -t"
  alias tls="t ls"
  alias tn="t new -t"

  alias draw="open -a /Applications/draw.io.app/"

  alias pass="lpass show --password -c"
  alias passes="lpass ls"

  alias findmd="find . -type f -name '*.md' -not -path '*/node_modules/*' | sort"
  # cat markdown files with a space between each
  alias catmd="findmd | xargs awk '(NR>1 && FNR==1){printf (\"\n\")};1'"
  [ {$CONFIG_LOG_LEVEL} -gt 0 ] ;and \
    echo "... Loaded ~/.config/fish/aliases.fish"
end
