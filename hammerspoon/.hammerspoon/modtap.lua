local M = {}

local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp

local ModTap = {
  keyCode = nil,
  modCode = nil,
  threshold = 0.1,
  down = false,
  held = false,
}
ModTap.__index = ModTap

function M.newModTap(config)
  local m = {}
  m.keyCode = config.keyCode
  m.modCode = config.modCode
  m.down = false
  m.held = false
  m.downTime = 0
  setmetatable(m, ModTap)
  return m
end

function ModTap:press()
  -- Do nothing when already pressed.
  if self.down then
    return
  end
  self.down = true
  -- After the threshold, the key is in the "held" state.
  self.timer = hs.timer.doAfter(self.threshold, function ()
    self.held = true
  end)
end

function ModTap:release()
  -- Do nothing when already up.
  if not self.down then
    return
  end

  -- When released before the modifier threshold, send a tap.
  if not self.held then
    M.keyEventHandler:stop()
    hs.eventtap.event.newKeyEvent({}, self.keyCode, true):post()
    hs.eventtap.event.newKeyEvent({}, self.keyCode, false):post()
    M.keyEventHandler:start()
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
  M.log.d("Key event: " .. key, et, f)
end

local function start()

  local modTaps = {}
  modTaps[keycodes.map.z] = M.newModTap({
    keyCode = keycodes.map.z,
    modCode = keycodes.map.ctrl,
  })
  modTaps[keycodes.map.x] = M.newModTap({
    keyCode = keycodes.map.x,
    modCode = keycodes.map.alt,
  })

  M.keyEventHandler = eventtap.new({keyDown, keyUp}, function (event)
    local keyCode = event:getKeyCode()
    local eventType = event:getType()
    local flags = event:getFlags()
    logEvent(keyCode, eventType, flags)

    local mt = modTaps[keyCode]

    if mt ~= nil then
      -- When the event match a mod-tap key, press or release it.
      if eventType == keyDown then
        mt:press()
      else
        mt:release()
      end
      return true
    end

    local heldModifiers = {}
    for _, k in pairs(modTaps) do
      if k.held then
        table.insert(heldModifiers, k.modCode)
      end
    end

    if next(heldModifiers) ~= nil then
      -- When any mod-taps are held, intercept and resend the event.
      if eventType == keyDown then
        M.keyEventHandler:stop()
        for _, modifier in ipairs(heldModifiers) do
          hs.eventtap.event.newKeyEvent(modifier, true):post()
        end
        hs.eventtap.event.newKeyEvent(keyCode, true):post()
        M.keyEventHandler:start()
      else
        M.keyEventHandler:stop()
        hs.eventtap.event.newKeyEvent(keyCode, false):post()
        for _, modifier in ipairs(heldModifiers) do
          hs.eventtap.event.newKeyEvent(modifier, true):post()
        end
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
  M.log = hs.logger.new('modtap.log', 'debug')
  start()
end

return M
