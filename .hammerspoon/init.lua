-- [[
-- TODO: Check if hotkeys are able to be bound by hammerspoon and warn if they're not: https://www.hammerspoon.org/docs/hs.hotkey.html#assignable
-- TODO: Investigate: https://github.com/miromannino/miro-windows-manager, seems pretty legit
-- TODO: Investigate this too https://www.hammerspoon.org/Spoons/PushToTalk.html
-- ]]

-- [[
--    Other stuff
-- ]]

-- Automatically reload config when init is saved
function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    reloadHammerspoon()
  end
end

function reloadHammerspoon()
  if caffeine then exitCaffeine() end
  hs.reload()
end

hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  reloadHammerspoon()
end)
-- hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

hs.hotkey.bind({"cmd"}, "Q", function()
  hs.alert.show("⌘ + Q Disabled")
end)

local logger = hs.logger.new('dotfiles','debug')


-- [[
--    Options
-- ]]

-- Shorten the animation duration, less jerky
hs.window.animationDuration = 0.01

-- Don't show window titles in hints
hs.hints.showTitleThresh = 0

-- Set up window hints characters to be in this order
--   right hand center row
--   left hand center row
--   right hand top row
--   left hand top row
--   center bottom row
hs.hints.hintChars =
  { "H", "J", "K", "L",
    "A", "S", "D", "F", "G",
    "Y", "U", "I", "O", "P",
    "Q", "W", "E", "R", "T",
    "C", "V", "B", "N" }


-- [[
--    Window Control
--
-- ]]

function alertShowCannotMoveWindow()
  hs.alert.show("Can't move window")
end

function withModifiers(app_name, frame)
  -- if app_name == 'iTerm2' then
  --   frame.w = frame.w + 5
  -- end

  return frame
end

-- Move current window to full screen
hs.hotkey.bind({"shift", "ctrl"}, "K", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local screen = win:screen()
  local max = screen:frame()

  win:setFrame(max)
end)

-- Move current window one screen East
hs.hotkey.bind({"shift", "ctrl"}, "L", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end

  win:moveOneScreenEast()
end)

-- Move current window one screen West
hs.hotkey.bind({"shift", "ctrl"}, "H", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end

  win:moveOneScreenWest()
end)

-- Move current window to left half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "H", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local app_name = win:application():title()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  f = withModifiers(app_name, f)
  win:setFrame(f)
end)

-- Move current window to right half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "L", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local app_name = win:application():title()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h

  f = withModifiers(app_name, f)

  win:setFrame(f)
end)

-- Move current window to bottom half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "J", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local app_name = win:application():title()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2

  f = withModifiers(app_name, f)
  win:setFrame(f)
end)

-- Move current window to top half of screen
hs.hotkey.bind({"cmd", "ctrl"}, "K", function ()
  local win = hs.window.focusedWindow()
  if not win then
    alertShowCannotMoveWindow()
    return
  end
  local app_name = win:application():title()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()


  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2

  f = withModifiers(app_name, f)
  win:setFrame(f)
end)

function reverse(tbl)
  for i=1, math.floor(#tbl / 2) do
    tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
  end
end

-- Window Hints like slate
--   Karabiner used to change cmd+tab to emmit F19
hs.hotkey.bind({""}, "F19", function ()
  -- [[
  -- TODO: Fix this
  -- TODO: The most recently used window appears to be the "bottom" one usually,
  --   but with vim the active window is the "top" one. Is this behavior consistent
  --   the default "windows"? Can we swap the order of the vim ones?
  -- TODO: Reversing them doesn't work with more than two windows :'(
  -- Issues with order:
  --   visible windows:
  --     Vim
  --       focused: top window cyles through all of them, current window is always the middle
  --       unfocused: same behavior
  --       focused2: Tried it again. Now the most-recent is always bottom. middle and top cycle.
  --       unfocused2: same behavior
  --     Firefox
  --       focused: (correct) top window is always most-recent, middle window is always second most-recent
  --       unfocused:
  --   Firefox puts the most-recent window at the top of the hint order, if it's focused.
  -- --      When it becomes unfocused, it mixes up the order somehow
  -- ]]

  local all_windows = hs.window.allWindows()
  -- logger.d("Length of all_windows is " .. #all_windows)
  -- logger.d("all windows: " .. hs.inspect.inspect(all_windows))
  local minimized_windows = hs.window.minimizedWindows()
  -- logger.d("Length of minimized_windows is " .. #minimized_windows)
  -- logger.d("minimized windows: " .. hs.inspect.inspect(minimized_windows))

  -- Show all windows except for those that are minimized.
  --   If we use 'visibleWindows' or 'orderedWindows' it doesn't show the Hammerspoon console for some reason.
  local hintable_windows = {}
  local minimized_window_ids = hs.fnutils.imap(minimized_windows, function(window)
    return window:id()
  end)
  logger.d("Minimized window ids: " .. hs.inspect.inspect(minimized_window_ids))
  for k,v in pairs ( all_windows ) do
    if not hs.fnutils.contains(minimized_window_ids, v:id()) then
      table.insert( hintable_windows, v )
    end
  end
  -- logger.d("Length of hintable_windows is " .. #hintable_windows)

  hs.hints.windowHints(hintable_windows, nil, true)
end)

-- Window hints including minimized
--   Note: Uses Karabiner to change cmd+shift+tab to emmit F20
hs.hotkey.bind({""}, "F20", function ()
  hs.hints.windowHints(hs.window.allWindows(), nil, true)
end)


-- [[
--    Spotify Hotkeys
-- ]]
hs.hotkey.bind({"ctrl", "shift"}, "P", function()
  hs.spotify.playpause()
end)

hs.hotkey.bind({"ctrl", "shift"}, "]", function()
  hs.spotify.next()
end)

hs.hotkey.bind({"ctrl", "shift"}, "[", function()
  hs.spotify.previous()
end)



-- [[
--    Teams Hotkeys
--    TODO: Get this working!
-- ]]
hs.hotkey.bind({"ctrl", "shift"}, "M", function()
  -- Send CMD + Shift + M to teams
  hs.alert.show("Muting not yet implemented")
end)


-- [[
--    Caffeine/Caffeinate/Amphetamine/KeepingYouAwake Replacement
--    TODO:
--      - Try to get SVG/path icons rather than files
--      - Support a right click menu with "Turn On for Duration"
--      - Support toggling it off at a certain battery percentage
--      - 2020-09-30 - It doesn't appear right away when starting hammerspon, gotta click the bar first
--    Icons from Gloria Kang: https://dribbble.com/shots/2049777-Retina-Caffeine-Menubar-Icons
--    Features to replace: http://semaja2.net/projects/insomniaxinfo/
-- ]]

caffeine = {}

caffeine.menu = hs.menubar.new(false)
caffeine.iconOn  = 'icons/caffeinate-on.png'
caffeine.iconOff = 'icons/caffeinate-off.png'
caffeine.menuTable = {
  { title = 'Exit', fn = function()
      exitCaffeine()
    end
  }
}

function exitCaffeine()
  caffeine.menu:delete()
  caffeine = nil
end

function setIcon(state)
  caffeine.menu:setIcon(state and caffeine.iconOn or caffeine.iconOff)
end

setIcon(hs.caffeinate.get("displayIdle"))

caffeine.menu:setMenu(function(modifiers)
  if modifiers.ctrl then
    return caffeine.menuTable
  else
    setIcon(hs.caffeinate.toggle("displayIdle"))
    return {}
  end
end)

caffeine.menu:returnToMenuBar()
