# My .dotfiles

Configure my computers, to reduce distraction and more keyboard focused.

## tl;dr

First time clone repository and install:

    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    ~/.dotfiles/bin/dotme

then update at any time with:

    dotme

This gets local up to date, including pulling latest version of this repository,
sets OSX defaults, updates brew including packages. This can be run anytime to
just get onto latest.

## Why

The configuration process in this repository provides me my preferred way of
working to streamline distraction free coding. This includes:

**brew**
: package manager

**fish**
: friendly interactive shell

**git**
: source control

**kitty**
: slick terminal

**tmux**
: terminal multiplexer

**neovim** with **Conquer of Completion**
: file editing

**FiraCode Nerd Font**
: ligatures, powerline and more

MacOS with

**[alfred](https://www.alfredapp.com/)**
: better hotkeys

**[dozer](https://github.com/Mortennn/Dozer)**
: focused status bar

**[magnet](https://magnet.crowdcafe.com/)**
: window manager

Other tools woven into these dotfiles are **fzf**, **pandoc**, **cspell**,
**node**, **java** and **python**.

## How

Various dotfiles are all located in sub-folders in the dotfiles/ folder for
various tools. On installation, each of these are stowed in to your home
directory, i.e. original backed up and dotfiles linked into place. Further
installation and configuration takes place with scripts in the bin/ directory,
however just look at bin/dotme to see what actually happens.

You can also update parts of the initialisation separately, see `dotme -h` to
get a list of each part. `man dotme` will give you more guidance on usage.

I configure a few things on my system [./docs/manual-configuration.md](manually)
for minor tweaks and enhancements.

## Thanks

Too many dotfiles projects out there that have given me inspiration to mention
them all, although [Awesome
dotfiles](https://github.com/webpro/awesome-dotfiles) make a good attempt to.
However, particular thanks to:

- [webpro](https://github.com/webpro/dotfiles)
- [Mathias](https://github.com/mathiasbynens/dotfiles)
- [Paul Irish](https://github.com/paulirish/dotfiles)
- [Managing dotfiles with stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
- [egel](https://github.com/egel/dotfiles)
- [Ultimate vim configuration](https://github.com/amix/vimrc)
- [noctuid - keyboard-based workflows](https://github.com/noctuid/dotfiles)
