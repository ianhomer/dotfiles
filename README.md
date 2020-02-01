# .dotfiles

Configure my computers, to reduce distraction and do less clickity-clickity.

# tl;dr

First time do:

    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    ~/.dotfiles/bin/dotme

Then update at any time with:

    dotme

This gets local up to date, including pulling latest version of this repository,
sets OSX defaults, updates brew including packages. This can be run anytime to
just get onto latest.

# Why?

The configuration process in this repository provides me my prefered way of
working to streamline distraction free coding. This includes:

* **brew** - package manager
* **fish** - friendly interactive shell
* **git** - source control
* **iterm** - terminal
* **vi** - file editing
* **FiraCode Nerd Font** - ligatures, powerline and more

It is also useful if you install a windows manager. My current favourute is
[Magnet](https://magnet.crowdcafe.com), but there are sevaral good ones out
there to choose from. You don't have to, however keyboard short cuts and window
optimisations are done under the assumption you have keyboard short cuts to
arrange your windows.

# How?

Various dotfiles are all located in sub-folders in the dotfiles/ folder for
various tools. On installation, each of these are stowed in to your home
directory, i.e. original backed up and dotfiles linked into place. Further
installation and configuration takes place with scripts in the bin/ directory,
however just look at bin/dotme to see what actually happens.

You can also update parts of the initialisation separately, see `dotme ?` to get
a list of each part.

# Thanks

Too many dotfiles projects out there that have given me inspiration to mention
them all, although [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles) make a good attempt to.
However, particular thanks to:

* [webpro](https://github.com/webpro/dotfiles)
* [Mathias]( https://github.com/mathiasbynens/dotfiles )
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Managing dotfiles with stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
* [egel](https://github.com/egel/dotfiles)
* [starcraftman](https://github.com/starcraftman/dot)

