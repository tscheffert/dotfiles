# Keybindings

## Debugging

Source: <https://vi.stackexchange.com/a/7723/9963>

List all custom mappings with explanation from where they're set:

```
:verbose map
```

Check if you've got a certain feature:

```
:version
```

Can also check it in code with:

see `:help feature-list` and `:help has()` for more info

```
has('feature')
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

Replace two newlines with one newline:

```
%s/\(\n\)\n/\1/g
```

Note that the replacement is a backreference because you can't enter a literal newline there for whatever reason.

## Windowing

### Switching buffers between two windows

Source: <http://vimcasts.org/episodes/working-with-windows/>

```
ctrl-w w cycle between the open windows
ctrl-w h focus the window to the left
ctrl-w j focus the window to the down
ctrl-w k focus the window to the up
ctrl-w l focus the window to the right
ctrl-w r rotate all windows
ctrl-w x exchange current window with its neighbour
ctrl-w H move current window to far left
ctrl-w J move current window to bottom
ctrl-w K move current window to top
ctrl-w L move current window to far right
```

## UltiSnips

### Python Interpolation

Pass values between interpolation instances in a given script:

```
`!p snip.rv = camelize(snip.basename); cache = { "camelized_filename": snip.rv}`

`!p snip.rv = cache["camelized_filename"]`.perform(args: ARGV)

```
