# Git Tips and Tricks

## Get current branch

Either:

```
git rev-parse --abbrev-ref HEAD
```

or

```
git symbolic-ref --quiet --short HEAD
```

The only difference I could find is that in 'detached HEAD' state the rev-parse
variant outputs 'HEAD' and the symbolic-ref variant errors with exit code 1.
