# Troubleshoot

## Known issues

My mac keyboard got it's ~ character mapped incorrectly I had to reset the
keyboard with

```bash
sudo mv /Library/Preferences/com.apple.keyboardtype.plist ~/tmp
```

and then restart my machine, to go through the keyboard re-initialisation. It
then remapped the ~ AOK. Not sure why it got it wrong first time.

## keyboard troubleshooting

In vi -> i -> <C-v> -> <key> combo => vi prints raw code.


## Reset Alfred Preferences

To change alfred to use local preferences, not synced one :

    mv ~/Library/Application\ Support/Alfred/prefs.json ~/tmp/alfred-prefs.json

