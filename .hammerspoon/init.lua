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
    hs.reload()
  end
end

hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  hs.reload()
end)
-- hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


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
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h

  win:setFrame(f)
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

-- Window Hints like slate
--   I used Karabiner to change cmd+tab to emmit F19
hs.hotkey.bind({""}, "F19", function ()
  hs.hints.windowHints(nil, nil, true)
end)


-- [[
--    Spotify Hotkeys
-- ]]
hs.hotkey.bind({"ctrl", "shift"}, "P", function()
  hs.spotify.playpause()
end)
