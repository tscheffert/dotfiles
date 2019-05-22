# Keybindings

## Debugging

Source: <https://vi.stackexchange.com/a/7723/9963>

List all custom mappings with explanation from where they're set:

```
:verbose map
```

## Search and Replace

Helpful: <http://vimregex.com/>

Remove a line from json:

```
:%s#,\n\s\+"version":\s"DEV-NOW"##g
```

Remove some text from a string:

```
%s#\/\#{\a\+}##g
```

Convert ruby string hashes to json:

```
%s/'/"/g
%s/\s\+=>/: /g
```
