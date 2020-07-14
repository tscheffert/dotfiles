# Git Repo Cleaning

- Goal remove large blobs

## Figure out what the largest blobs are

Get the size of the largest blobs

```
$ git-largest-blobs
=>
019f74d1430e   41MiB helm/linux-amd64/tiller
08f0b90d290f   40MiB helm/linux-amd64/helm
abc96a4cda26   25MiB helm/helm-v2.14.2-linux-amd64.tar.gz
e45bc940dc1b  391KiB ceph/ceph-deploy-ceph.log
5451341ba982  154KiB ceph/ceph-deploy-ceph.log
2e60c7727b58  139KiB ceph/ceph-deploy-ceph.log
c723411d9589   63KiB charts/echotrak-redis/README.md
741f036e2946   45KiB operators/crds/kiali/getLatestKialiOperator
413fd60fc15e   43KiB charts/demo/kafka/README.md
2f37f2e2d5ee   36KiB charts/datadog/README.md
566e3853e686   32KiB charts/demo/rabbitmq/README.md
a6b2b2bb4b72   28KiB charts/datadog/values.yaml
871ce6850962   28KiB charts/datadog/values.yaml
1e1647571fd0   28KiB charts/demo/kafka/charts/zookeeper/README.md
660183099150   28KiB charts/datadog/values.yaml
```

Determine what to delete.
The two easiest way to remove things is via folder names and file-size limits, as that is what BFG supports.
In this case, `helm/linux-amd64/` is a good folder to delete, and then file size limits work for ceph deploy logs and the helm tar.

## Use BFG

<https://rtyley.github.io/bfg-repo-cleaner/>

## Clean Folders with BFG

Example:

```
java -jar c:/tools/bfg/current/bfg.jar --strip-blobs-bigger-than <size-to-remove> --no-blob-protection <cloned-repo-folder>
```

Where `<size-to-remove>` is a size like `340K` or `2M` and `<cloned-repo-folder>` is the path to your repo that you cloned.

## Clean by Filesize with BFG

```
java -jar c:/tools/bfg/current/bfg.jar --delete-folders <folders-to-remove> --no-blob-protection <cloned-repo-folder
```


Where `<folder-to-remove>` is the folder you want to remove and `<cloned-repo-folder>` is the path to your repo that you cloned.



## later
git reflog expire --expire=now --all && git gc --prune=now --aggressive
