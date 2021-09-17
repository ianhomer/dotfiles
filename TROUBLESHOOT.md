# Troubleshoot

## Known issues

My Mac keyboard got it's ~ character mapped incorrectly I had to reset the
keyboard with

```sh
sudo mv /Library/Preferences/com.apple.keyboardtype.plist ~/tmp
```

Then restart my machine, to go through the keyboard re-initialisation. It then
remapped the ~ AOK. Not sure why it got it wrong first time.

# keyboard troubleshooting


In vi -> i -> `Ctrl+v` -> `key` combo => vi prints raw code.

Install keycastr to see key presses on screen

Simple execute

    brew cask install keycastr

To debug key presses into kitty terminal

    kitty --debug-keyboard

## Reset Alfred Preferences

To change Alfred to use local preferences, not synced one :

    mv ~/Library/Application\ Support/Alfred/prefs.json ~/tmp/alfred-prefs.json

## Troubleshoot Vim Performance

    :profile start vim-performance.log
    :profile file *
    :profile func *
    :profile stop

Look at the bottom of the log file for a sorted summary

Also generate a start-up time report with:

    :StartupTime
