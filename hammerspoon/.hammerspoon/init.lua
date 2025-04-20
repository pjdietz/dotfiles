hs.loadSpoon("EmmyLua")
hs.loadSpoon("FnMate")

local modtap = require("modtap")
modtap.init({
  threshold = 0.2,
  keys = {
    ["z"] = { hold = { "ctrl" } },
    ["x"] = { hold = { "alt" } },
    -- ["c"] = { hold = { "cmd" } },
    -- [","] = { hold = { "cmd" } },
    -- ["."] = { hold = { "alt" } },
    -- ["/"] = { hold = { "ctrl" } },
    ["escape"] = { hold = { "ctrl", "cmd" } },
    ["tab"] = { hold = { "ctrl", "alt", "cmd" } },
  }
})

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

-- Notification when the configuration is loaded
hs.alert.show("Hammerspoon config loaded")
