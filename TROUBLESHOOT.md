# Troubleshoot

## Known issues

My mac keyboard got it's ~ character mapped incorrectly I had to reset the
keyboard with

```bash
sudo mv /Library/Preferences/com.apple.keyboardtype.plist ~/tmp
```

and then restart my machine, to go through the keyboard re-initialisation. It
then remapped the ~ AOK. Not sure why it got it wrong first time.
