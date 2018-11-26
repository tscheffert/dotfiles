## Windows Ruby

Working shell on our windows servers:
```powershell
& "C:\opscode\chef\embedded\bin\pry.bat"
```

## Changes to files

### Remove lines matching regex from files

Pipe a list of files to `sed -i '/regex/d'` to remove lines matching `regex` in-place.

Example:
```bash
gdfom | xargs sed -i "/#create\ 'Event\ Log'\ sources/d"
```

### Open files matching regex in gvim

Pipe a list of files to `xargs gvim` and they'll open up in buffers. Pipe it through
`aw '{print $1}'` to normalize new lines, which is required for whatever reason on
_mingw64_.

```bash
gdfom | xargs ag --files-with-matches 'artifact_deploy_service' | awk '{print $1}' | xargs gvim
```

## Maintenance

### Clean up Git repos

[Git clean docs](https://git-scm.com/docs/git-clean):

> Cleans the working tree by recursively removing files that are not under version control, starting from the current directory.

Print out files that would be cleaned, including things in `.gitignore`:
```bash
$ git clean --dry-run -x -d
```

Clean everything, including what would be ignored by `.gitignore`:
```bash
$ git clean -x -d
```

### Garbage Collect Git Repos

[Docs](https://git-scm.com/docs/git-gc)

```bash
$ git gc --aggressive
```

### Set Git author information

Make sure config is correct:
```bash
git config --global user.name "John Doe"
git config --global user.email "john@doe.org"
```

Rebase and reset:
```bash
git rebase -i origin/develop
# Set each command to edit and run this:
git commit --amend --reset-author --no-edit && git rebase --continue
```


## Other?

### List all of the users on a system

```bash
awk -F':' '{ print $1 }' /etc/passwd
```

### List of all files that have been moved in a git repo

```bash
find -name .git -prune -o -exec git log --pretty=tformat:'' --numstat --follow {} ';' | grep '=>'
```

### List of all the usernames for environments in Chef vault

```
ag -i "\"username\"" data_bags/chef_vault/production.key | awk '{$1=$1;print}' | sed 's#.\{1,3\}: "username": ##g' | sort | uniq | clip.exe
```

### Windows Symlinks

Source: <https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/mklink>

Use `/d` for directories, files are default.

```
mklink [/d] <Destination> <Source>
```

Example:

```
mklink /d C:\tools\thing\current C:\tools\thing\v123
```

Preface with `cmd /c` to use from bash/zsh.

Full example:

```
$ cmd /c 'mklink /d C:\tools\ruby\ridk\current C:\tools\ruby\ridk\Ruby25-x64'
symbolic link created for C:\tools\ruby\ridk\current <<===>> C:\tools\ruby\ridk\Ruby25-x64
```



## Problem?

### No origin/HEAD?

Problem:
```
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref
```

Solution:
```
git remote set-head origin master
```
