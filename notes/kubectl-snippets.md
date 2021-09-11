# Kubectl Snippets

## Get all Failing Pods
```
kubectl get po --all-namespaces | gawk 'match($3, /([0-9])+\/([0-9])+/, a) {if (a[1] < a[2] && $4 != "Completed") print $0}' | egrep -v '\-job'
```

## Scale Deployment to Zero

```
kubectl scale deployment.v1.apps/echo-xp-optshipmentconnector-api --replicas=0
```

## Install MSSQL tools

```
apt-get install gnupg

```
