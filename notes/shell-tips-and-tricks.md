# Shell Tips and Tricks

## Windows Ruby

Working shell on our windows servers:

```powershell
& "C:\opscode\chef\embedded\bin\pry.bat"
```

## Git Tip & Tricks

### Rebase without messing up dates

```
git rebase --committer-date-is-author-date
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

> Cleans the working tree by recursively removing files that are not under version
> control, starting from the current directory.

Print out files that would be cleaned, including things in `.gitignore`:

```bash
$ git clean --dry-run -x -d
```

Clean everything, including what would be ignored by `.gitignore`:

```bash
$ git clean -x -d -i
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

### Clean up Chef Server Logs

```
cd /var/log/opscode
sudo find ./opscode-expander -name '*.[us]' | sudo xargs rm
sudo find ./oc_bifrost -name 'requests.log*[0-9]' | sudo xargs rm
sudo find ./opscode-erchef -name 'requests.log*[0-9]' | sudo xargs rm
sudo find ./opscode-reporting -name 'reporting.log*[0-9]' | sudo xargs rm
sudo find ./opscode-solr4 -name '*.s' | sudo xargs rm
```

### Finding lost git commits

Source: <https://confluence.atlassian.com/bbkb/how-to-restore-a-deleted-branch-765757540.html>

Generate a list of commits that are present but unreachable:

```
git fsck --full --no-reflogs --unreachable --lost-found | grep commit | cut -d\  -f3 | xargs -n 1 git log -n 1 --pretty=oneline > .git/lost-found.txt
```

View commit chains from "lost" items:

```
git log -n 5 --name-only --oneline <commit>
```

View contents of chains:

```
git log -n 5 -p <commit>
```

Clean up lost and found when you're done:

```
rm .git/lost-found.txt
git gc
```

If you really want to get rid of _everything_:

```
git reflog expire --expire-unreachable=now --all
git gc --prune=now
```

## Finding things

### Running a command on all directories in a path

Note: Running `find` with `-print0` and `xargs` with `-0` handles filenames with
spaces, or (god forbid) newlines, correctly.

```
find . -maxdepth 1 -type d -print0 | xargs -0 --max-args=1 ls
```

```
find . -maxdepth 1 -type d ! -path . -execdir 'echo {}' +
```

```
find . -maxdepth 1 -type d -print0 | xargs -0 --max-args=1 --verbose -I _ cd _ && pwd && cd -
```

### List all directories except the "dot" current directory

Note: You can use `!` to negate expressions from the find arguments, we exclude
items that match `-path .` here.

```
find . ! -path . -type d
```

## Vim

[Source](https://vi.stackexchange.com/a/16657/9963)

Capture scriptnames output

```
vim -c ':set t_ti= t_te= nomore' -c 'scriptnames' -c 'q!'
```

or:

```
vim -c "redir! > vimout | scriptnames | redir END | q"
```

## Other?

### Run a command in a loop every few seconds

```
while sleep 5; do clear; <command>; done
```

### Run a command in a range

```
END=9; for ((i=1;i<=END;i++)); do knife cookbook delete role_common_app "123.456.$i" -y --config ~/.chef/sandbox/knife-dev.rb; done
```

### Create a new sudo user

```bash
sudo adduser <username>
sudo passwd <username>
sudo usermod -aG wheel <username>
```

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

## Ruby

### Split tabular input into one word per line

This:

```
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
```

Into:

```
aes-128-cbc
aes-128-ecb
aes-192-cbc
aes-192-ecb
...
```

```bash
echo "stuff" | ruby -e "STDIN.each_line.to_a.flat_map(&:split).map(&:strip).each(&method(:puts))"
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
