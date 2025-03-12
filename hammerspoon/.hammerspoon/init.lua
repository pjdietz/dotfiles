hs.loadSpoon("EmmyLua")

local keyboard = require("keyboard")
keyboard.setup()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, false):post()
  hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
  hs.eventtap.event.newKeyEvent("2", true):post()
  hs.eventtap.event.newKeyEvent("2", false):post()
end)

-- Notification when the configuration is loaded
hs.alert.show("Hammerspoon config loaded")
