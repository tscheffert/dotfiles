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


## Other?

### List all of the users on a system

```bash
awk -F':' '{ print $1 }' /etc/passwd
```
