# Setup

## Install Git SDK from `git-for-windows/build-extra`

Download from the [Releases page](https://github.com/git-for-windows/build-extra/releases)

Double click and install to `C:/git-sdk-64`

## Add `C:/git-sdk-64/usr/bin` to the PATH in the System Env Variables

Put it towards the top.

Otherwise vim and lots of other things will have issues.

## Install Zsh

```bash
pacman -S zsh
```

## Install Ruby native installer thing

TODO: Do we actually need this?

Though I'm not super sure what this actually does. Presumably it makes it easier
to install native ruby packages?

```bash
pcaman -S mingw-w64-x86_64-ruby-native-package-installer
```

## Get rid of `C:/git-sdk-64/.git`

Just zip it up and then delete it, we can unzip later if needed. This causes _every_
directory to be a git directory within the git-for-windows zsh installation, which
is annoying and _super slow_ for the prompt.

## Clean up default git-sdk-64 configs

### Comment out the entirety of a few files

Comment out:

- `C:\git-sdk-64\etc\profile.d\bash_completion.sh`
- `C:\git-sdk-64\etc\profile.d\bash_profile.sh`
- `C:\git-sdk-64\etc\profile.d\git-prompt.sh`
- `C:\git-sdk-64\etc\profile.d\git-sdk.sh`

### Clean up the `/etc/profile.d/aliases.sh`

Comment out the `ls` and `ll` aliases. Leave the `winpty` prefix alias for now.

### Clean up the `/etc/profile/` file

- Comment out `PS1` assignment in the `elif [ ! "x${ZSH_VERSION}" = "x" ]` block.

## Get a working Ruby

Go to the [RubyInstaller for Windows downloads page](https://rubyinstaller.org/downloads/)
and download the latest _Ruby+Devkit .* (x64)_ version.

Install under `C:\tools\ruby\ridk\`, so the full install path would be something
like `C:\tools\ruby\ridk\Ruby25-x64`.

Uncheck `Add Ruby executables to your PATH`, the `zsh/windows` file does that.

Uncheck `Associate .rb and .rbw files with this Ruby installation`, we don't need
that.

Uncheck `Use UTF-8 as default external encoding`, the `zsh/exports` file does that.

When selecting components, check `MSYS2 development toolchain`, our normal gitsdk
one doesn't work.

After it's installed, check `Run 'ridk install' to setup MSYS2 and development toolchain`.

Press enter with the default install options, `[1, 2, 3]` and install the stuff.

Symlink the versioned directory to a generic path so that the shell path exports
work.

```
cmd /c 'mklink /d C:\tools\ruby\ridk\current C:\tools\ruby\ridk\Ruby25-x64'
```

## References

- <https://github.com/git-for-windows/MINGW-packages>
- <https://github.com/git-for-windows/MSYS2-packages>
- <https://github.com/git-for-windows/msys2-runtime>

## Problems and Solution

### Deprecated `git-completion.zsh` warning

#### Problem

When starting _ConEmu_ console as _zsh_, or running `exec zsh` from _bash_, I get
the following:

```
WARNING: this script is deprecated, please see git-completion.zsh
compinit:141: parse error: condition expected: $1
C:\git-sdk-64\mingw64/share/git/completion/git-completion.bash:3277: command not found: compdef
```

#### Solution

Turns out this is because _zsh_ automatically sources the `C:\\git-sdk-64/etc/profile`
that comes with the _git-sdk-64_ which sources a bunch of stuff.

I've manually changed, or removed, the following files:

- `C:\\git-sdk-64\\etc\\profile`
- `C:\\etc\\profile.d\\git-prompt.sh` (commented everything out)
- `C:\\etc\\profile.d\\bash\_profile.sh` (commented everything out)

NOTE: I should potentially do something about `/etc/inputrc`

### Issue with installing `charlock_holmes`

If i starts with an error like this:

```
ERROR:  Error installing charlock_holmes:
        ERROR: Failed to build gem native extension

...

To see why this extension failed to compile, please check the mkmf.log which can be found here:

  C:/tools/ruby/ridk/Ruby25-x64/lib/ruby/gems/2.5.0/extensions/x64-mingw32/2.5.0/charlock_holmes-0.7.6/mkmf.log

extconf failed, exit code 1

...
```

Then install the gem dependencies like this:

```
ridk.cmd exec pacman -S mingw-w64-x86_64-icu icu-devel icu
```

Ensure the temp path is set up correctly:

```
# These should be in dotfiles
export tmp="$(cygpath -m "/tmp")"
export TMP="$(cygpath -m "$TMP")"
export TEMP="$(cygpath -m "$TEMP")"
export TMPDIR="$(cygpath -m "$TMPDIR")"
```

Then install the gem like this:

```
gem install charlock_holmes -- --with-icui18nlib=icuin --with-icudatalib=icudt
```

## Install utilities with Pacman

### Install man

```bash
pacman -S man
```

### Install TaskWarrior

```bash
pacman -S task
```

### Install colordiff

Package description:

> Diff wrapper with pretty syntax highlighting

To install:

```bash
pacman -S colordiff
```

## Pacman Frequent Tasks

Helpful: <https://wiki.archlinux.org/index.php/Pacman/Rosetta>

### Synchronize Package Databases and upgrade all outdated packages

```bash
pacman -Syyu
```

### Clear the package cache

```bash
pacman -Sc
```

