# todo

* Create a way to report on any files not checked in any of my bookmarked places
  * z, fastd or autojump, z.lua
* fzf glitching like - https://github.com/junegunn/fzf.vim/issues/927 - switched
    to installing plugin from source to get glitch fix. Need to verify official
    way to install plugin after fix released in fzf.

## backlog

* Improve report tool (use python)
  * brew leaves - report what's been explicitly installed (over and above
    dotfiles), suggest what packages should be removed / auto-prune option
* Pre-run xcode-select --install
* Assess cmus
* If necessary execute npm install -g npm
* Change default shell to fish - currently done manually with
    `chsh -s /usr/local/bin/fish`
* Disable Mac OS auto correct keyboard -> text
* Use includeIf to include git config per organisation / user profile
* Automatically load tmux plugins, currently need to do C-a I
* Get ta fish completion working, tmux a -t works, how do we register an alias
    for autocompletion
* Try the following coc-html,coc-highlight,coc-yank
* Auto jenv enable-plugin maven
* Digest aliases from https://preslav.me/2020/03/01/use-the-git-history/
* Make man page search case insensitive, e.g. less -i - perhaps this should be
    default less options system wide
* Try limelight again
* Use cSpell tools to compile dictionaries trie files from txt words file
* How to make dictionary files available to other tools (other than vim)
