# future

A few areas are on my mind to improve. These are simply background hobby
investigations.

## keyboard configuration

All my systems and keyboards need to be consistent

- Disable Mac OS auto correct keyboard -> text

## spelling

Spelling customisations need to be shared between environments

- Use cSpell tools to compile dictionaries trie files from txt words file
- How to make dictionary files available to other tools (other than vim)

## OS compatibility

It'll be good to try out these dotfiles in non-mac environment

- Deploy dotfiles in docker to test fresh install on other OS

## vim and CoC

- Try coc-eslint, coc-flow (typescript)
- experiment with markdown linting more, doesn't seem to lint list line wrapping
  well. `gq` shortcut ends up putting line wrap in a new list item. Can `:Format`
  be improved to just sort this out?

## health checks

Simple report to indicate what could be improved with the environment

- report on launchtl services on startup / suggest pruning. `launchtl list`,
  `ls /Library/LaunchAgents`,`ls /Library/LaunchDaemons`. Look at errors in start
  up logs to report which are zombies
- Bring coc troubleshooting practice into play :CocInfo, :checkhealth,
  :CocOpenLog, :version
- Report on what's running that I may have started but don't need, e.g.
  vim instances, mysqld, docker, bluetooth

## watch

Items from todo list, which might not be needed anymore:

- Change default shell to fish - currently done manually with
  `chsh -s /usr/local/bin/fish`
- Automatically load tmux plugins, currently need to do C-a I
- Auto jenv enable-plugin maven




