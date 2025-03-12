local M = {}

local eventtap = require("hs.eventtap")

local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp

local log = hs.logger.new('modtap.log', 'debug')

local function logEvent(keyCode, eventType)
  local key = hs.keycodes.map[keyCode]
  local et = " [keyDown]"
  if eventType == keyUp then
    et = " [keyUp]"
  end
  log.d("Key event: " .. key, et)
end

local function start()
  log.d("start")

  local e = eventtap.new({keyDown, keyUp}, function (event)
    local keyCode = event:getKeyCode()
    local eventType = event:getType()
    logEvent(keyCode, eventType)
  end)

  e:start()
end

function M.init(config)
  config = config or {}
  start()
end

return M
