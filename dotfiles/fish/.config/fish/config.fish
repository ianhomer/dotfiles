status --is-interactive; and source (rbenv init - | psub)

set PATH ~/.dotfiles/bin $PATH

source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish

# Work around for OSX issue causing slow autocompletion - https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command; end

echo "...Loaded ~/.cnfig/fish/config.fish"

