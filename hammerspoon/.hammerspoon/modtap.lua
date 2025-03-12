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
    M.log.i("ModTap sending key events for mod down")
    self.held = true
    -- hs.eventtap.event.newKeyEvent(self.modCode, true):post()
  end)
end

function ModTap:release()
  M.log.d("ModTap:release()")
  if not self.down then
    M.log.d("ModTap is already up")
    return
  end
  M.log.i("ModTap released")

  if not self.held then
    M.log.i("ModTap sending key events for tap")
    M.keyEventHandler:stop()
    hs.eventtap.event.newKeyEvent({}, self.keyCode, true):post()
    hs.eventtap.event.newKeyEvent({}, self.keyCode, false):post()
    M.keyEventHandler:start()
  else
    M.log.i("ModTap sending key events for mod up")
  end

  self.down = false
  self.held = false
  if self.timer then
    self.timer:stop()
    self.timer = nil
  end
end

local function logEvent(keyCode, eventType, flags)
  local key = hs.keycodes.map[keyCode]
  local et = " [keyDown]"
  if eventType == keyUp then
    et = " [keyUp]"
  end
  local f = " {"
  for k, _ in pairs(flags) do
    f = f .. k
  end
  f = f .. "}"
  M.log.i("Key event: " .. key, et, f)
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
    local flags = event:getFlags()
    logEvent(keyCode, eventType, flags)

    if keyCode == mt.keyCode then
      if eventType == keyDown then
        M.log.d("DOWN for mod tap key")
        mt:press()
        return true
      else
        M.log.d("UP for mod tap key")
        mt:release()
        return true
      end

    elseif mt.held then
      if eventType == keyDown then
        M.log.i("Add the modTap modifier [down]")
        M.keyEventHandler:stop()
        hs.eventtap.event.newKeyEvent(mt.modCode, true):post()
        hs.eventtap.event.newKeyEvent(keyCode, true):post()
        M.keyEventHandler:start()
      else
        M.log.i("Add the modTap modifier [up]")
        M.keyEventHandler:stop()
        hs.eventtap.event.newKeyEvent(keyCode, false):post()
        hs.eventtap.event.newKeyEvent(mt.modCode, false):post()
        M.keyEventHandler:start()
      end
      return true
    end

    return false
  end)

  M.keyEventHandler:start()
end

function M.init(config)
  config = config or {}
  M.log = hs.logger.new('modtap.log', 'info')
  start()
end

return M
