# Backup App

## TODO

- Script to capture GitHub directory entries
- Script to capture Tools directory entries
- Script to capture:
  - Gems
  - npm packages
  - pip packages
  - paths
  - Chocolatey packages
- Script to capture pacman, windows, and chocolatey programs
- Somehow get these programs config:
  - Typora Config
  - Gimp config
  - 1Password vault
  - WOX Config
- Font

## Script plan

### Phase One

- Take a list of files to backup
- Foreach file
  - Backup with backup ruby gem

### Phase Two

- Take a list of directories to backup
- Take a list of "other" to backup

### Behavior

- For each strategy determine behavior for:
  - If directory or file doesn't exist
  - If md5 hasn't changed
  - If it's too big

## Use This

- <https://github.com/backup/backup>
