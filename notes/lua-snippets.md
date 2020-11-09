# Lua Snippets

## General

### Join two tables

```
local hintable_windows = {}
for k,v in pairs ( ordered_windows ) do
  table.insert( hintable_windows, v )
end
for k,v in pairs ( minimized_windows ) do
  table.insert( hintable_windows, v )
end
```

## Hammerspoon

### Log a inspected variable

```lua
logger.d("Minimized windows: " .. hs.inspect.inspect(minimized_windows))
```

### Log a concatenated string

```lua
logger.d("Found minimized_window " .. minimized_window:id() " at index " .. window_index)
```

### Iterate through a list of windows

```lua
logger.d("Minimized Windows: ")
for i,minimized_window in pairs(minimized_windows) do
  logger.d("  " .. minimized_window:id())
end
```

### Filter to nonstandard windows

```lua
  local all_windows = hs.window.allWindows()
  local nonstandard_windows = hs.fnutils.filter(all_windows, function(window)
    return not window:isStandard()
  end)

  logger.d("Length of nonstandard_windows is " .. #nonstandard_windows)
```

### Find a specific window based on title

```lua
local hammerspoon_window = hs.window.find('Hammerspoon Console')
logger.d("hammerspoon windows: " .. hs.inspect.inspect(hammerspoon_window) or "wtf")
```
