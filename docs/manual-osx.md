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

### Magnet

Install Magnet and change keyboard shortcuts.

|              |                  |
| ------------ | ---------------- |
| `Ctrl-Alt-,` | Previous Display |
| `Ctrl-Alt-.` | Next Display     |

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
- Magnet

## Install Apps

I often use the following, installing them manually as needed

- Slack
- YubiKey manager
- [Wally](https://www.zsa.io/wally/) - Moonlander configuration
- ObinsKit - AnnePro configuration

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

### Keyboard Configuration - MacOS

System preferences

-> Keyboard -> Shortcuts ->

- Disable Mission Control Ctrl-arrow short cuts
- Disable Ctrl-space and Shift-Ctrl-space for selecting input source
- Disable any other shortcuts that would never get used
- Change Press **globe/fn** to "Show Emoji and Symbols"

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

### Additional developer tools

JDK 11

    brew tap homebrew/cask-versions
    brew install --cask zulu11

- Visual Studio 2022
- Android Studio and generate a .env in your project hierarchy

```sh
cat-dotenv-android > .env
```

### M1 Tweaks

#### .NET

Install v3.1, v5 and v6 as needed from Microsoft Downloads. Don't use Brew,
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
- -> .NET Core CLI Execution path = /use/local/share/dotnet/x64/dotnet

Restart and on solution -> Manage .NET SDK -> Select 5.0

#### Xcode

Find Xcode in Application, click Get Info and select open in Rosetta.
