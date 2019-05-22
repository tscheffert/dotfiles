# NPM Installed Apps

## tldr

Docs:
<https://www.npmjs.com/package/tldr>

Install:

```
npm install -g tldr
```

Usage:

```
# tldr 'tar' for example

tldr <thing>
```

Update:

```
tldr --update
```

## Livedown

```
npm install -g livedown
```

## elasticdump

Docs:
<https://github.com/taskrabbit/elasticsearch-dump>

Install:

```
npm install -g elasticdump
```

Usage:

```
elasticdump \
  --input=http://production.es.com:9200/my_index \
  --output=http://staging.es.com:9200/my_index \
  --type=data
```
