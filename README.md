# My .dotfiles

Configure my computers, to reduce distraction and and with less
clickity-clickity.

## tl;dr

First time clone repository and install:

    git clone git@github.com:ianhomer/dotfiles.git ~/.dotfiles
    ~/.dotfiles/bin/dotme

Then update at any time with:

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

**neovim** with **Conquerer of Completion**
: file editing

**FiraCode Nerd Font**
: ligatures, powerline and more

**[alfred](https://www.alfredapp.com/),
[dozer](https://github.com/Mortennn/Dozer),
[magnet](https://magnet.crowdcafe.com/)**
: MacOS+ with better hotkeys, focused status bar and window manager

## How

Various dotfiles are all located in sub-folders in the dotfiles/ folder for
various tools. On installation, each of these are stowed in to your home
directory, i.e. original backed up and dotfiles linked into place. Further
installation and configuration takes place with scripts in the bin/ directory,
however just look at bin/dotme to see what actually happens.

You can also update parts of the initialisation separately, see `dotme -h` to
get a list of each part.

## Manual Configuration

I've not worked out how to automate all configuration. Until I do, this is what
I manually do on each environment.

### Initialise a few desktop apps

#### Dozer

Open dozer and configure menu hiding.

### Alfred

Open Alfred, set up privacy options, point configuration to a cloud storage of
your choosing, and configure Alfred to your choosing.

Alfred Preferences -> Advanced -> Set Preferences folder -> ~/.dotfiles/config/alfred

### Keyboard Configuration - MacOS

System preferences

-> keyboard -> Modifier Keys -> For each keyboard :

- Caps Lock -> Escape

-> Mission Control - remove all keyboard and mouse shortcuts

For a Microsoft keyboard :

- Option Key -> Command
- Command Key -> Option

And then use [keyboard shortcuts](https://support.google.com/mail/answer/6594) -
see [Cheatsheet](./CHEATSHEET.md) for my favourites.

### Gmail

Gmail -> Settings -> Keyboard Shortcuts -> Keyboard shortcuts on

## Spelling

Spell checking in vi takes place with
[coc-spell-checker](https://github.com/iamcco/coc-spell-checker) which uses
[cspell](https://www.npmjs.com/package/cspell).

The coc configuration in the vim configuration in these dotfiles explicitly adds
the dotfiles.txt, dottech.txt and dotinbox.txt files in ~/.config/dictionaries.
This is in addition to the [default
dictionaries](https://github.com/iamcco/coc-spell-checker) added by the
coc-spell-checker plugin, which includes conditional dictionaries based on file
language, e.g. javascript, python specific spelling. This provides a default set
of dictionaries for all local development.

Project specific words are configured in the cspell.json file in the project
root.

Other dictionaries could be loaded from
[coc-spell-dicts](https://github.com/iamcco/coc-cspell-dicts) following that
project README, and from
[cspell-dicts](https://github.com/streetsidesoftware/cspell-dicts) by adding
global package to install-node-packages script.

Per-project custom dictionaries can be added to the project ~/.cpsell.json,
e.g.

    "dictionaries": [
      "lorem-ipsum"
    ],


To trace where a word is defined:

    cspell trace <word>

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
