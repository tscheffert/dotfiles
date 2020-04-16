#! /usr/env/bin bash
#
# Programatically set up osx hotkeys. These are the same as in
#   SystemPreferences -> Keyboard -> Shortcuts
#
#   Source: http://superuser.com/questions/670584/how-can-i-migrate-all-keyboard-shortcuts-from-one-mac-to-another
#   Additional Info: http://osxnotes.net/keybindings.html

# Set a shortcut to "\1" to disable it
# Run `defaults find NSUserKeyEquivalents` to see current set keys

defaults write -app Chrome NSUserKeyEquivalents '{
"Reload This Page" = "\\Uf708";
}'
