# Problem:
When starting _ConEmu_ console as _zsh_, or running `exec zsh` from _bash_, I get
the following:
```
WARNING: this script is deprecated, please see git-completion.zsh
compinit:141: parse error: condition expected: $1
C:\git-sdk-64\mingw64/share/git/completion/git-completion.bash:3277: command not found: compdef
```

# Solution:
Turns out this is because _zsh_ automatically sources the `C:\\git-sdk-64/etc/profile` that
comes with the _git-sdk-64_ which sources a bunch of stuff.

I've manually changed, or removed, the following files:

- C:\\git-sdk-64\\etc\\profile
- C:\\etc\profile.d\\git-prompt.sh (commented everything out)
- C:\\etc\\profile.d\\bash\_profile.sh (commented everything out)


NOTE: I should potentially do something about `/etc/inputrc`
