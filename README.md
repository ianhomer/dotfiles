# My .dotfiles

Configure my computers to be more keyboard focused and reduce distraction. Make
coding and text editing a breeze.

## tl;dr

First time, clone repository:

    git clone https://github.com/ianhomer/dotfiles.git ~/.dotfiles

And install with

    ~/.dotfiles/start

Update at any time with:

    dotme

This gets local machine up to date, including pulling latest version of this
repository, sets OSX defaults, updates brew including packages. Run this at any
time to update to latest. It updates what's changed or out of date, so it's
quick and painless.

I remind myself of commands and shortcuts I use with:

    cheat

## Why

The configuration process in this repository provides me with my preferred way
of working to streamline distraction free coding. This includes:

**brew**
: package manager

**fish** and **zsh**
: friendly interactive shells

**git**
: source control

**kitty**
: slick terminals

**tmux**
: terminal multiplexer with plugins - tmux-continuum ; tmux-resurrect ;
  vim-tmux-navigator

**neovim**
: file editing with plugins - airline ; ale ; dispatch ; fugitive ;
  fzf.vim ; lsp ; markdown-preview ; nerdtree ; repeat ; startify ;
  surround ; tabular ; which-key ; surround

**nnn** and **broot**
: file explorers

**FiraCode Nerd Font**
: ligatures, powerline and more

**termux**
: Android support

MacOS with

**[alfred](https://www.alfredapp.com/)**
: better hotkeys

**[hiddenbar](https://github.com/dwarvesf/hidden)**
: focused status bar

**[magnet](https://magnet.crowdcafe.com/)**
: window manager

**Fantastical** calendar.

Other tools woven into these dotfiles include **ag**, **fzf**, **pandoc**,
**cspell**, **fugitive**, **java**, **node** and **python**.

## How

dotfiles are all located in sub-folders in the dotfiles/ folder for the
associated tools. Installation stows these in your home directory, i.e. original
backed up and dotfiles linked into place. Further installation and configuration
takes place with scripts in the bin directory. Look at bin/dotme to see what
actually happens.

You can also update parts of the initialisation separately, see `dotme -h` to
get a list of each part. `man dotme` will give you more guidance on usage.

I configure something on my system [manually](./docs/manual-osx.md)
for minor tweaks and enhancements.

To customise local dotme configuration, `vi ~/.config/dotme/.env` and edit a
properties to look like:

```properties
MY_NOTES=my-notes
```

## Thanks

A large number of dotfiles projects out there that have given me inspiration to
mention them all, although [Awesome
dotfiles](https://github.com/webpro/awesome-dotfiles) make a good attempt to.
Particular thanks to:

- [webpro](https://github.com/webpro/dotfiles)
- [Mathias](https://github.com/mathiasbynens/dotfiles)
- [Paul Irish](https://github.com/paulirish/dotfiles)
- [Managing dotfiles with
  stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
- [egel](https://github.com/egel/dotfiles)
- [Ultimate vim configuration](https://github.com/amix/vimrc)
- [noctuid - keyboard-based workflows](https://github.com/noctuid/dotfiles)
