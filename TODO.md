# todo

## backlog

- Create a way to report on any files not checked in any of my bookmarked places
  - z, fastd or autojump, z.lua
- Improve report tool (use python)
  - brew leaves - report what's been explicitly installed (over and above
    dotfiles), suggest what packages should be removed / auto-prune option
- Pre-run xcode-select --install
- If necessary execute npm install -g npm
- Change default shell to fish - currently done manually with
  `chsh -s /usr/local/bin/fish`
- Disable Mac OS auto correct keyboard -> text
- Use includeIf to include git config per organisation / user profile
- Automatically load tmux plugins, currently need to do C-a I
- Auto jenv enable-plugin maven
- Use cSpell tools to compile dictionaries trie files from txt words file
- How to make dictionary files available to other tools (other than vim)
- Ignore package-lock.json for spelling
- Deploy dotfiles in docker to test fresh install on other OS
- Try coc-eslint, coc-flow (typescript)
- Set default directory for tmux window so new panes start in given directory
- experiment with markdown linting more, doesn't seem to lint list line wrapping
  well. `gq` shortcut ends up putting line wrap in a new list item. Can `:Format`
  be improved to just sort this out?
- report on launchtl services on startup / suggest pruning. `launchtl list`,
  `ls /Library/LaunchAgents`,`ls /Library/LaunchDaemons`. Look at errors in start
  up logs to report which are zombies
- network speed monitoring, e.g. `npm install --global fast-cli`
- try java and python code completion on all envs
- Update spelling add word to only add to .cspell.json not also
  .vim/coc-settings.json
- Bring coc troubleshooting practice into play :CocInfo, :checkhealth, :CocOpenLog, :version
- Report on what's running that I may have started 
  but don't need, e.g.
  vim instances, mysqld, docker, bluetooth
- Try tmuxinator
- Coc add spelling should to just cspell.json not .vim config
- Why CoC sometimes stopping? Doesn't always seems to start up right and I have
  to restart with leader vc
- Perhaps start up CoC optionally when needed and shut down if not needed - TBD
- Missing spelling, e.g. anonymised, anonymized, should be in core dictionary
- Node install needs to install into node version used by default shell, e.g.
    nvm global version in fish shell, currently install-node-packages is
    installing from bash shell, perhaps need to set up nvm in bash shell too. I
    prefer bin scripts to not use fish where possible.
- Only install npm package in install-node-packages if not already installed and
  update existing ones if updates are avilable.
