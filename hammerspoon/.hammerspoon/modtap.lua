local M = {}

local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp


local ModTap = {
  keyCode = nil,
  modCode = nil,
  threshold = 0.2,
  downTime = 0,
  down = false,
  held = false,
}
ModTap.__index = ModTap

function M.newModTap(config)
  local m = {}
  m.keyCode = config.keyCode
  m.modCode = config.modCode
  m.downTime = 0
  m.down = false
  m.held = false
  m.downTime = 0
  setmetatable(m, ModTap)
  return m
end

function ModTap:press()
  M.log.d("ModTap:press()")
  if self.down then
    M.log.d("ModTap is already down")
    return
  end
  M.log.i("ModTap pressed")
  self.down = true
  self.timer = hs.timer.doAfter(self.threshold, function ()
    M.log.i("ModTap held")
    self.held = true
  end)
end

function ModTap:release()
  M.log.d("ModTap:release()")
  if not self.down then
    M.log.d("ModTap is already up")
    return
  end
  M.log.i("ModTap released")
  self.down = false
  self.held = false
  if self.timer then
    self.timer:stop()
    self.timer = nil
  end
end

local function logEvent(keyCode, eventType)
  local key = hs.keycodes.map[keyCode]
  local et = " [keyDown]"
  if eventType == keyUp then
    et = " [keyUp]"
  end
  M.log.d("Key event: " .. key, et)
end

local function start()
  M.log.d("start")

  -- TODO: Define in config
  local mt = M.newModTap({
    keyCode = keycodes.map.z,
    modCode = keycodes.map.ctrl,
  })

  M.keyEventHandler = eventtap.new({keyDown, keyUp}, function (event)
    local keyCode = event:getKeyCode()
    local eventType = event:getType()
    logEvent(keyCode, eventType)

    if keyCode == mt.keyCode then
      if eventType == keyDown then
        M.log.d("DOWN for mod tap key")
        mt:press()
      else
        M.log.d("UP for mod tap key")
        mt:release()
      end
    end

  end)

  M.keyEventHandler:start()
end

function M.init(config)
  config = config or {}
  M.log = hs.logger.new('modtap.log', 'info')
  start()
end

return M
