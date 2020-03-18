:e
todo

* Create a way to report on any files not checked in any of my bookmarked places
  * z, fastd or autojump, z.lua
* fzf glitching like - https://github.com/junegunn/fzf.vim/issues/927 - switched
    to installing plugin from source to get glitch fix. Need to verify official
    way to install plugin after fix released in fzf.

## backlog

* Assess pandoc
* Remove NERDTree once fully OK with netrw
* Improve report tool (use python)
  * brew leaves - report what's been explicitly installed (over and above
    dotfiles), suggest what packages should be removed / auto-prune option
* Can we store learnt spelling dictionary? And make available to all tools?
    ~/Library/Spelling/LocalDictionary
* Pre-install plugins in vi (currently vi has to be started and :PlugUpdate run)
* Pre-run xcode-select --install
* Assess cmus
* If necessary execute npm install -g npm
* Change default shell to fish - currently done manually with
    `chsh -s /usr/local/bin/fish`
* Disable Mac OS auto correct keyboard -> text
* assess neofetch
* Use includeIf to include git config per organisation / user profile
* Automate set up of caps lock as escape key
* Automatically load tmux plugins, currently need to do C-a I
* Get ta fish completion working, tmux a -t works, how do we register an alias
    for autocompletion
* gx glitched for me to open external URL - why?
* cheat for listing bind keys consider maping prefix [ ] to
    moving pane left right in tmux.  What about up / down?
* how to make the osx key mapping diff clearer to read, e.g. aligned with git
    diff-color.
* Try the following coc-json, coc-yaml, coc-tsserve, coc-html, coc-java,
    https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
    coc-highlight,
    coc-git, coc-yank, coc-xml, coc-markdownlint, coc-spell-checker
* Auto jenv enable-plugin maven
* Digest aliases from https://preslav.me/2020/03/01/use-the-git-history/
* Create mechamism to test keyboard output so that I can customise keyboard and
    learn how to remap keys.
    https://apple.stackexchange.com/questions/317548/how-do-i-get-the-calculator-button-on-a-microsoft-sculpt-keyboard-working
* Create man page like https://unix.stackexchange.com/questions/6891/how-can-i-add-man-page-entries-for-my-own-power-tools
* Make mane page search case insensitve, e.g. less -i - perhaps this should be
    default less options system wide
* Take reporting of keyboard layout out from install scripts
