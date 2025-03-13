hs.loadSpoon("EmmyLua")

-- local keyboard = require("keyboard")
-- keyboard.setup()

local modtap = require("modtap")
modtap.init()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Notification when the configuration is loaded
hs.alert.show("Hammerspoon config loaded")
