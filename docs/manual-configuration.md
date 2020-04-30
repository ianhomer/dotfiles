# Manual Configuration

I've not worked out how to automate all configuration. Until I do, this is what
I manually do on each environment.

## Initialise a few desktop apps

### Dozer

Open dozer and configure menu hiding.

### Alfred

Open Alfred, set up privacy options, point configuration to a cloud storage of
your choosing, and configure Alfred to your choosing.

Alfred Preferences -> Advanced -> Set Preferences folder -> ~/.dotfiles/config/alfred

### Slack

Optimise slack performance

Preferences -> Accessibility -> Allow animated images and emoji

### Keyboard Configuration - MacOS

System preferences

-> Keyboard -> Modifier Keys -> For each keyboard :

- Caps Lock -> Escape

-> Keyboard -> Shortcuts ->

- Disable Mission Control Ctrl-arrow short cuts
- Disable any other shortcuts that would never get used

-> Mission Control - remove all keyboard and mouse shortcuts

For a Microsoft keyboard :

- Option Key -> Command
- Command Key -> Option

And then use [keyboard shortcuts](https://support.google.com/mail/answer/6594) -
see [Cheatsheet](./docs/cheats/) for my favourites.

### Spotlight

Optimise Spotlight so that it's only used for application find.

System Preferences -> Spotlight -> Search Results -> remove all categories
except Applications

System Preferences -> Spotlight -> Privacy -> add following directories

- /System/Library/Frameworks
- /System/Library/Perl
- /System/Library/PrivateFrameworks
- /System/iOSSupport
- /Library/Developer
- /Library/Java/
- /opt
- /usr/local/Caskroom
- /usr/local/Cellar
- /usr/local/Homebrew
- /usr/local/lib
- /usr/local/opt
- /usr/local/share
- /usr/local/texlive

- ~/Library/Android
- ~/Library/Python

- ~/archive
- ~/projects
- ~/Downloads

To report on what folders are in your index use `show-spotlight`.

### Gmail

Gmail -> Settings -> Keyboard Shortcuts -> Keyboard shortcuts on
