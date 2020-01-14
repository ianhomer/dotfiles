status --is-interactive; and source (rbenv init - | psub)

set PATH ~/.dotfiles/bin $PATH

if status --is-interactive
  source ~/.config/fish/aliases.fish
  source ~/.config/fish/functions.fish

  # Work around for OSX issue causing slow autocompletion - https://github.com/fish-shell/fish-shell/issues/6270
  function __fish_describe_command; end

  # Use vi key bindings
  fish_vi_key_bindings
  echo "... Loaded ~/.cnfig/fish/config.fish"
end
