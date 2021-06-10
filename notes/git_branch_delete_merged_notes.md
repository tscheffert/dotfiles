# Git Branch Delete Merged Notes


## Feature #1

TODO: Local `run-duration` branch created, tracking origin/run-duration, when I pull
  down master and the origin/run-duration branch has been deleted then local run-duration
  should get deleted, but it doesn't

Example:

```
┌───── { 60 } [../k8s-yaml](add-gitattributes-prod)
└──>>> gco dev1 && gp
Switched to branch 'dev1'
Your branch is up to date with 'origin/dev1'.
From vs-ssh.visualstudio.com:v3/echo-it/DevCenter/k8s-yaml
 - [deleted]         (none)     -> origin/add-gitattributes-dev1
remote: Azure Repos
remote: Found 1 objects to send. (3 ms)
Unpacking objects: 100% (1/1), done.
   93ef1ef..5a3e402  dev1       -> origin/dev1
First, rewinding head to replay your work on top of it...
Fast-forwarded dev1 to 5a3e402f4bf81006dcd8fe62ca939de6f7fabaab.
┌───── { 61 } [../k8s-yaml](dev1)
└──>>> gbd-m
Pruning with 'git remote prune origin'
┌───── { 62 } [../k8s-yaml](dev1)
└──>>> gb
    add-elastic-no-name-tool
    add-gitattributes-dev1
    add-gitattributes-prod
    add-gitattributes-qa1
  * dev1
    prod
    qa1
```

## Issue #1

TODO: Doesn't work with multiple remotes

```
>>> gbd-m --remote
error: unable to delete 'tlrg/ETA-MultiTargetFrontENd': remote ref does not exist
error: failed to push some refs to 'git@git.echo.com:slalom-configuration-management/infrastructure-deploy.git'
C:/Users/tscheffert/.dotfiles/bin/git_branch_delete_merged:116:in `out!': !!! Command 'git push origin --delete tlrg/ETA-MultiTargetFrontENd' failed with out:  (RuntimeError)
        from C:/Users/tscheffert/.dotfiles/bin/git_branch_delete_merged:202:in `block in perform'
        from C:/Users/tscheffert/.dotfiles/bin/git_branch_delete_merged:199:in `each'
        from C:/Users/tscheffert/.dotfiles/bin/git_branch_delete_merged:199:in `perform'
        from C:/Users/tscheffert/.dotfiles/bin/git_branch_delete_merged:222:in `<main>'
-- Deleting branch on origin: tlrg/ETA-MultiTargetFrontENd
45 -1- [../infrastructure-deploy](master) >>> gb
    beautify-testing
  * master
    tlrg-envs-prodlike
    tlrg-tlrg-boxes
    utility-scripts
46 [../infrastructure-deploy](master) >>> git remote
origin
tlrg
```

