# .dotfiles

Configure my computers, to reduce distraction and do less clickity-clickity.

# tl;dr

First time do:

    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    ~/.dotfiles/bin/dotme

Then update at any time with:

    dotme

This gets local up to date, including pulling latest version of this repository, sets OSX defaults, updates brew
including packages. This can be run anytime to just get onto latest.

# Why?

This dotfiles configuration is based about my prefered way of working to streamline distraction free coding. This
includes:

* **brew** - package manager
* **fish** - friendly interactive shell
* **git** - source control
* **iterm** - terminal
* **vi** - file editing

It is also useful if you install a windows manager, e.g. Magnet. You don't have to, however keyboard short cuts and
window optimisation is done under the assumption you have keyboard short cuts to arrange your windows.

# How?

dotfiles are all located in sub-folders in the dotfiles/ folder based on the tool name. Each of these are stowed in to
home directory, i.e. original backed up and dotfile linked into place. Further installation and configuration takes
place with scripts in the bin/ directory, however just look at bin/dotme to see what actually happens.

You can also update parts of the initialisation separately, see `dotme ?` to get a list of each part.

# Thanks

Too many dotfiles projects out there that have given me inspiration to mention them all, although [Awesome
dotfiles](https://github.com/webpro/awesome-dotfiles) make a good attempt to. However particular thanks to:

* [webpro](https://github.com/webpro/dotfiles)
* [Mathias]( https://github.com/mathiasbynens/dotfiles )
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Managing dotfiles with stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
