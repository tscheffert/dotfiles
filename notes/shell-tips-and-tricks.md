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

### Get the pretty git tag/commit for versioning

```
git describe --tags --match "v*" --always --long HEAD
git describe --always --long --tags HEAD
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
gdfom | xargs ag --files-with-matches '2021-03-26' | awk '{print $1}' | xargs gvim
```

### Get the path to a bash script, regardless of where it's run

```
bash_file_path="$(realpath "${BASH_SOURCE[0]}")"
```

### Get the root of the repo from a bash script

Do this:

```
repo_root="$(git -C "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" rev-parse --show-toplevel)"
```

Explanation:

The output of this file:

```
bash_file_path="${BASH_SOURCE[0]}"
echo "Bash file path: $bash_file_path"
real_bash_file_path="$(realpath "$bash_file_path")"
echo "Real bash file path: $real_bash_file_path"
real_path_dirname="$(dirname "$real_bash_file_path")"
echo "Real path dirname: $real_path_dirname"

git -C "$real_path_dirname" rev-parse --show-toplevel
```

Looks like this:

```
Bash file path: test.sh
Real bash file path: /Users/tscheffert/dev/azure-devops/devops/artifactory-cloud/test.sh
Real path dirname: /Users/tscheffert/dev/azure-devops/devops/artifactory-cloud
/Users/tscheffert/dev/azure-devops/devops/artifactory-cloud
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

### Deleting folders matching a path

```
# Run the command to doublecheck output
find . -wholename '*/bin/Debug/*' -type d

# Run it again to delete
find . -wholename '*/bin/Debug/*' -type d | xargs rm -r
```

### Cleaning build artifacts from visual studio projects

```
find . -wholename '**/bin/Debug' -type d | xargs rm -r
find . -wholename '**/bin/Debug' -type d -exec rm -r "{}" +
```

### Delete folders that contain subfolders

```
```

### Find and delete all things matching a given name

```
find . -name '.DS_Store' -delete
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

## YQ

Load an array of yaml objects, filter them, then output only a subset of keys:

```
yq eval '.[] | select(.server_role == "TLRG*") | {"server_role": .server_role, "depdendent_applications": .dependent_applications} | splitDoc' qa1-server-roles_overlay.yml
```

## Other?

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

### Browse to another person's harddrive in explorer

```
\\tscheffert-p510\c$\kitchen-vms
```

### strace something?

```
sudo strace -f -p 22279 -e trace=file
```

### Remove a specific folder from the path

```
export PATH="${PATH%?(:)/directory/to/remove}"
```

Because `${string%substring}` will remove the shortest match of `$substring` from the back of `$string` via parameter expansion.

`?(:)` will match zero or one instances of `:`, which means it will still delete the path if it's at the start of the path.

- Parameter Expansion: <https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html>
- Pattern Matching: <https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching>

### Rename hidden files

```bash
for name in .zsh_history*; do
  trimmed_name=${name#.zsh_history} # remove suffix with parameter expansion
  prefixed_name=".zsh$trimmed_name.history"

  echo "Move $name to $prefixed_name"
  mv "$name" "$prefixed_name"
done
```

### Convert SVG files

```
# On Mac
brew install librsvg

# On Windows using Chocolaty
choco install rsvg-convert

# Do the convert
#   Note: Add a background with: --background-color white
rsvg-convert -w 1024 -h 1024 --output icons/shell-file.png icons/shell-file.svg
```

### Print the current date

```
date +"%Y-%m-%d_%H-%M-%S%Z"
```

### Print the current date in rfc3339

```
date --rfc3339=seconds
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


## WGET

```
#!/usr/bin/env bash


# Steps:
# Go to browser, login, go to "root" index page
# Open inspector with F12, go to the network inspector and enable it
# ctl+f5 to force refresh the page, find the Index.html ntework request, right click and 'Copy as curl (bash)'
# Paste in vim download.sh file
# Search replace -H for --header and -D for --post-data


wget --header 'Connection: keep-alive' --header 'Pragma: no-cache' --header 'Cache-Control: no-cache' --header 'DNT: 1' --header 'Upgrade-Insecure-Requests: 1' --header 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36' --header 'Sec-Fetch-Dest: document' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' --header 'Sec-Fetch-Site: same-origin' --header 'Sec-Fetch-Mode: navigate' --header 'Sec-Fetch-User: ?1' --header 'Referer: https://EXAMPLE.com/Members/Login' --header 'Accept-Language: en-US,en;q=0.9' --header 'Cookie: __RequestVerificationToken=stuff; .ASPXAUTH=thing' --mirror --convert-links --page-requisites --no-parent -P ./test-output-dir/ 'https://EXAMPLE.com/Members/Index'
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
