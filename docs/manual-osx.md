# Manual Configuration OSX

I've not worked out how to automate all configuration. Until I do, this is what
I manually do on each environment.

## Configure core apps

### Browsers

I use multiple browsers to 1) allow different persistent sessions I can jump
between and 2) test cross browser functionality:

The ones I install by default (in order of my preferred browser):

1. [brave](https://brave.com/)
2. [edge](https://www.microsoft.com/en-us/edge)
3. [chrome](https://www.google.com/intl/en_uk/chrome/)

I install bitwarden extension in each browser

### Hidden Bar

Open Hidden Bar. Select "Start Hidden Bar when I log in" and "Enable always
hidden section".

### Alfred

Open Alfred and add powerpack license

Alfred Preferences -> Advanced -> Set Preferences folder ->
~/.dotfiles/config/alfred

## Login Items

Set the following to start on login

- Alfred 4
- Rectangle

## Finder

- Preferences
  - Keep folders on top when sorting by name
  - Remove AirDrop
  - Set explicit tags, e.g. "admin", "projects", "personal"
  - Open folders in tabs, not windows
- Customise toolbar
  - name
  - show
  - info
  - path
  - view
  - (remove search, since never use finder search)
- Click on Macintosh HD - `cmd-J` select always open in list view
- Services - Services Preferences, just
  - new Kitty Window
  - Folder Actions set up
- Show preview

## Google Drive

[Install Google Drive](https://www.google.com/intl/en-GB/drive/download/). Set
up folders to backup from local machine. Set up the syncing options to be mirror
files choosing `~/gdrive` as the location.

- `~/.local/share/buku/`

## Install Apps

I often use the following, installing them manually as needed

- Slack
- Miro
- YubiKey manager
- Bitwarden Desktop <https://bitwarden.com/download/>
- [Wally](https://www.zsa.io/wally/) - Moonlander configuration
- ObinsKit - AnnePro configuration

### Additional developer tools

- xcode
- Visual Studio 2022
- Android Studio

More tools installed adhoc

    brew install azure-cli
    brew install k6
    brew install cocoapods
    brew install --cask powershell
    brew install --cask flipper

JDK 11

    brew tap homebrew/cask-versions
    brew install --cask zulu11

For Android Studio projects generate a .env in your project hierarchy

```sh
cat-dotenv-android > .env
```

## Uninstall Apps

I uninstall the follow apps since they provide no value to me:

- Garage Band
- iMovie
- Numbers
- Pages
- Keynote

## Configure other apps

### Slack

Optimise slack performance

Preferences -> Accessibility -> Allow animated images and emoji

### Dock & Menu Bar Configuration - MacOS

- Clock - Show Date - Always
- Now Playing - Untick Show in Menu Bar

### Trackpad Configuration - MacOS

System preferences -> Trackpad -> Point & Click

- Disable Look up & data detectors

### Keyboard Configuration - MacOS

Disable all keyboard shortcuts I don't use.

System preferences -> Keyboard -> Keyboard Shortcuts ->

- Disable Mission Control Ctrl-arrow short cuts
- Disable Ctrl-space and Shift-Ctrl-space for selecting input source
- Disable any other shortcuts that would never get used
- Change Press **fn** key to "Show Emoji and Symbols"

-> Mission Control - remove all keyboard and mouse shortcuts

For a Microsoft keyboard :

- Option Key -> Command
- Command Key -> Option

And then use [keyboard shortcuts](https://support.google.com/mail/answer/6594) -
see [cheat sheet](./docs/cheats/) for my favourites.

#### Keyboard - MacOS default

-> Keyboard -> Modifier Keys -> For each keyboard :

- Caps Lock -> Escape

Use `Shift-3` for # and `Alt-3` for £. Feels more natural to me and aligns with
mechanical keyboards.

-> Keyboard -> Input Sources -> U.S.

### Finder - Set list by default

- Open Finder
- Select Macintosh HD
- `Command-J`
- Select Always open in list mode

### Spotlight

Optimise Spotlight for application find.

System Preferences -> Spotlight -> Search Results -> remove all categories
except Applications

System Preferences -> Spotlight -> Privacy -> add following directories

- `/System/Library/Frameworks`
- `/System/Library/Perl`
- `/System/Library/PrivateFrameworks`
- `/System/iOSSupport`
- `/Library/Developer`
- `/Library/Java/`
- `/opt`
- `/usr/local/Caskroom`
- `/usr/local/Cellar`
- `/usr/local/Homebrew`
- `/usr/local/lib`
- `/usr/local/opt`
- `/usr/local/share`
- `/usr/local/texlive`

- `~/Library/Android`
- `~/Library/Python`

- `~/archive`
- `~/projects`
- `~/Downloads`

To report on what folders are in your index use `show-spotlight`.

### Browser

Install
[Surfkeys](https://chrome.google.com/webstore/detail/surfingkeys/gfbliohnnapiefjpjlpjnehglfpaknnc)
for vim like keys in browser. Type `?` in browser for help.

### Gmail

Settings -> Keyboard Shortcuts -> Keyboard shortcuts on

### M1 Tweaks

#### .NET

Install v3.1, v5, and v6 as needed from Microsoft Downloads. Don't use Brew,
since a little bleeding edge at the moment.

v6 on M1

    dotnet --list-sdks

V5 and v3.1 on x64 (with Rosetta)

    dotnetx64 --list-sdks

#### JetBrains Rider

For .NET 5 and .NET 3.5 development

- -> Properties
- -> Build, Execution & Deployment
- -> Toolset and Build
- -> .NET Core CLI Execution path = `/use/local/share/dotnet/x64/dotnet`

Restart and on solution -> Manage .NET SDK -> Select 5.0

#### Xcode

Find Xcode in Application, click Get Info and select open in Rosetta.
