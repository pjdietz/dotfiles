hs.loadSpoon("EmmyLua")

local modtap = require("modtap")
modtap.init({
  keys = {
    z = { hold = "ctrl" },
    x = { hold = "alt" },
    c = { hold = "cmd" },
  }
})

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Notification when the configuration is loaded
hs.alert.show("Hammerspoon config loaded")
