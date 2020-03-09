# Shortcuts

if type which-dotme-aliases 2>/dev/null
  echo "... WARN : dotme aliases have already been defined"
  which-dotme-aliases
else
  alias which-dotme-aliases="echo '~/.config/fish/aliases.fish'"
  alias vi="nvim"

  # git
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

  alias docme="find . -type f -name '*.md' -not -path '*/node_modules/*'"\
" | xargs cat | pandoc -s -d ~/.pandoc/pandoc -o"
  [ {$CONFIG_LOG_LEVEL} -gt 0 ] ;and \
    echo "... Loaded ~/.config/fish/aliases.fish"
end
