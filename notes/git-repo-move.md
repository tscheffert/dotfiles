# Goal

- Move subset of _SourceRepo_ into _DestinationRepo_
- Keep relevant history
- Don't bring along extraneous history

## Newest Plan

- Clone source repo
- Revert --hard to desired point in history
- Delete remote-tracking branches
- Determine list of shared targets
- Determine list of unique targets
- Determine renames of shared and unique targets in history
- In source repo, rename historical files shared targets to desired future name
- Run GitRocketFilter with giant `--keep` lists into a branch for target repo
- Clone target repo
- Make a new branch in target repo
- Pull the for-target-repo branch into the target repo
  - MAYBE: In target repo, rename historical files unique targets to desired
  future name
- Push branch and profit

*Note:* This assumes adding history from an "already split without history" repo
to an existing repo. Most steps will work for simply splitting a repo, adjust
accordingly.

## Steps

### Set Up GitRocketFilter

```bash
git clone https://github.com/xoofx/GitRocketFilter && cd GitRocketFilter
```

Fix the `.\build.bat` to get the Visual Studio vars working.

Build in powershell:

```
C:\tools\nuget\nuget.exe sources add -name "nuget.org" -source https://www.nuget.org/api/v2/
C:\tools\nuget\nuget.exe restore .\GitRocketFilter.sln
.\build.bat
```

### Rewrite target repo history into a branch of source repo

Make a list of all "shared files" and all "unique files" for the target repo and
put them in txt docs, in `.gitignore` format. Run `GitRocketFilter` wrapper script
with those files.

```bash
extract_git_history_subset shared_files.txt unique_files.txt
```

### Pull in history from another repo

Note: This obeys your config, so it pulls via rebase

```bash
git checkout -b historical-branch
git pull file:///path/to/source-repo target-repo-branch
```

### Join histories

Ensure you're on the right branch:

```bash
git checkout historical-branch
```

Find the rewritten commits from the target branch, grab the SHA before them:

```bash
git log
```

Gets rid of those commits, we want to merge them:

```bash
git reset --hard SHA-BEFORE-REWRITTEN-COMMITS
```

Now to merge the histories. There will be merge conflicts, but you pretty much always
want "theirs". Additionally, it seems like everything gets marked as a conflict even
if it was automatically resolved. You'll have to mark as added each file and then
check the diff.

```bash
git merge origin/develop --allow-unrelated-histories
git status
git diff
vim thing-needing resolution # Resolve the conflict, almost certainly going with "theirs"
git add thing-needing-resolution
git add thing-auto-resolved
git diff --cached # Review the changes being merged
```

Push and Merge Request, then you're done:
```bash
git push
```

# Common Tasks

## Take Out The Trash

```bash
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

## List number of commits reachable from HEAD

```bash
git rev-list --count HEAD
```

## List renamed files

Two main methods, searching for `{.* => .*}`:

```bash
find -name .git -prune -o -exec git log --pretty=tformat:'' --numstat --follow --find-copies-harder --reverse {} ';' | cut -f3- | ag '{.* => .*}'
```

or using `--diff-filter=R`, which only lists files that were marked as "Renamed":

```bash
find -name .git -prune -o -exec git log --pretty=tformat:'' --numstat --follow --diff-filter=R --reverse {} ';' | cut -f3- | ag --invert-match "(^.chef/|Berksfile|Rakefile)"
```

## List deleted files

```
find -name .git -prune -o -exec git log --pretty=tformat:'' --numstat --follow --diff-filter=D --reverse {} ';' | cut -f3- | ag --invert-match "(^.chef/|Berksfile|Rakefile|.delivery/)"
```

## Find renames of specific file

```bash
git log --follow --pretty=format:"%h %s %cD" --name-status -- path/to/file
```

# Other

```bash
git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now
```

```
git filter-branch --index-filter \
  'git ls-files -s | sed "s-\t-&<subdir path>/-" | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info && mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
```

## Fix the commit date on the rewritten commits

```
git rebase --committer-date-is-author-date FIRST-REWRITTEN-HASH-FROM-MOMENTS-AGO
```

# Medium Old Plan

- Clone source repo
- Revert --hard to desired point in history
- Delete remote-tracking branches
- Determine list of shared targets
- Determine list of unique targets
- Determine renames of shared and unique targets in history
- In source repo, rename historical files shared targets to desired future name
- Copy source repo and rename to target repo as a sibiling to source repo
- In target repo, rename historical files unique targets to desired future name
- Create directory representing new target repo root
- Move shared and unique targets into target repo root
- Separate targets with a subtree split
- Push subtree as new root

## Old plan steps

### Add remote to _DestinationRepo_

```bash
git remote add upstream git@git.echo.com:slalom-configuration-management/chef-repo
git fetch upstream
```

### Rebase history into branch

```bash
git checkout -b add-history
git rebase upstream/master
```

### Remove remote-tracking Branches

Get a list of remote-tracking branches for your remote:

```bash
git remote show upstream
```

Trim the list down to the branches you want to remove. Save them in a file,
`branches.txt` for example.

Delete using a script from my dotfiles bin:

```bash
git_delete_remote_tracking_branches upstream branches.txt
```

*Note:*
This removes the local remote-tracking branches, which can be seen with
`git branch -a` or `git branch -vv`. It doesn't remove information about which
branches are present on the remote, meaning that you can still see the branches
in the output of `git remote show upstream`. They will have switched to a status
of `new` rather than `tracked` in that output though.

# Really Old Plan

Using BFG was originally the plan. Pull the history into the target repo, then remove
everything that was unrelated.

Two issues with this though:

- BFG doesn't allow full globs for directories or files, so `cookbooks/thing/Rakefile`
and `./Rakefile` both get cleansed.
- BFG doesn't produce a branch with the changes as the result as well as rewriting
all of the refs, meaning it's _NOT_ good for "trial and error". I spent a lot of
time copying a folder and running it then deleting the folder and trying again.

## Download BFG Repo-Cleaner

Make sure you have `java` in your path with `which java`.

From here: <https://rtyley.github.io/bfg-repo-cleaner/>

Put it in `C:/tools/bfg/vX.Y.Z`, with the appropriate verison. Link the versioned jar:

```
# mklink DESTINATION SOURCE
cmd /c mklink "C:\tools\bfg\current\bfg.jar" "C:\tools\bfg\v1.13.0\bfg-1.13.0.jar"
```

## Prune Stuff From History

This didn't work

Clean up all references of a given directory:

```
bfg --delete-folders app-redwood --no-blob-protection
```
