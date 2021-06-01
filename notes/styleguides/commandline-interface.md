# Commandline Interface Styleguide

## Useful Pages
- <https://clig.dev/>
- <https://blog.developer.atlassian.com/10-design-principles-for-delightful-clis/>
- <https://github.com/leemunroe/cli-style-guide>
- <https://devcenter.heroku.com/articles/cli-style-guide>


## Glossary

- angle brackets ( `<` / `>` )
- square brackets ( `[` / `]` )
- parentheses ( `(` / `)` )

## Help Text

### Open-ended Arguments

Surround open ended arguments with angle brackets ( `<` / `>` ) and then explain the expected values.

Example:

```
examplecli <script_to_run>
  script_to_run is the local path to the script you want to run with examplecli
```

### Optional Arguments

Wrap optional arguments in square brackets.

Example:

```
examplecli do_command [--dry-run]
  --dry-run will only simulate what running the command would do
```

Use angle brackets if the parameter is open ended





```
git stash list [<log-options>]
git stash show [<diff-options>] [<stash>]
git stash drop [-q|--quiet] [<stash>]
git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
git stash branch <branchname> [<stash>]
git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
              [--pathspec-from-file=<file> [--pathspec-file-nul]]
              [--] [<pathspec>...]]
git stash clear
git stash create [<message>]
git stash store [-m|--message <message>] [-q|--quiet] <commit>
```
