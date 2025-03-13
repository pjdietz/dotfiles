local M = {}

local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp

local keysFromFlags
local keyCodesFromFlags
local mergeAndMakeUnique
local logEvent

-- ModTap ----------------------------------------------------------------------

local ModTap = {
  keyCode = nil,
  modCode = nil,
  threshold = 0.1,
  down = false,
  held = false,
}
ModTap.__index = ModTap

function ModTap.new(config)
  local m = {}
  m.keyCode = config.keyCode
  m.modCode = config.modCode
  m.down = false
  m.held = false
  m.downTime = 0
  m.parent = nil
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

function ModTap:release(modifiers)
  -- Do nothing when already up.
  if not self.down then
    return
  end

  -- When released before the modifier threshold, send a tap.
  if not self.held then
    if self.parent then
      modifiers = modifiers or {}
      self.parent:sendTap(self.keyCode, modifiers)
    end
  end

  self.down = false
  self.held = false
  if self.timer then
    self.timer:stop()
    self.timer = nil
  end
end

-- ModTapSet -------------------------------------------------------------------

local ModTapSet = {}
ModTapSet.__index = ModTapSet

function ModTapSet.new()
  local m = {
    modTaps = {},
    handler = nil
  }
  return setmetatable(m, ModTapSet)
end

function ModTapSet.__index(self, key)
  local method = rawget(ModTapSet, key)
  if method then
    return method
  end
  return self.modTaps[key]
end

-- @param mt (ModTap)
function ModTapSet:add(mt)
  self.modTaps[mt.keyCode] = mt
  mt.parent = self
end

function ModTapSet:held()
  local heldModifiers = {}
  for _, k in pairs(self.modTaps) do
    if k.held then
      table.insert(heldModifiers, k.modCode)
    end
  end
  return heldModifiers
end

function ModTapSet:sendKeyDown(keyCode, modifiers)
  modifiers = modifiers or {}
  modifiers = mergeAndMakeUnique(modifiers, self:held())

  self.handler:stop()
  for _, modifier in ipairs(modifiers) do
    hs.eventtap.event.newKeyEvent(modifier, true):post()
  end
  hs.eventtap.event.newKeyEvent(keyCode, true):post()
  self.handler:start()
end

function ModTapSet:sendKeyUp(keyCode, modifiers)
  modifiers = modifiers or {}
  modifiers = mergeAndMakeUnique(modifiers, self:held())

  self.handler:stop()
  hs.eventtap.event.newKeyEvent(keyCode, false):post()
  for _, modifier in ipairs(modifiers) do
    hs.eventtap.event.newKeyEvent(modifier, false):post()
  end
  self.handler:start()
end

function ModTapSet:sendTap(keyCode, modifiers)
  for _, k in pairs(modifiers) do
    M.log.d("MOD " .. k)
  end
  self.handler:stop()
  hs.eventtap.event.newKeyEvent(modifiers, keyCode, true):post()
  hs.eventtap.event.newKeyEvent(modifiers, keyCode, false):post()
  self.handler:start()
end

function ModTapSet:start()
  -- Configure the keyboard event handler.
  self.handler = eventtap.new({keyDown, keyUp}, function (event)
    local keyCode = event:getKeyCode()
    local eventType = event:getType()
    local flags = event:getFlags()
    logEvent(keyCode, eventType, flags)

    -- When the event matches a mod-tap key, press or release it.
    local mt = self.modTaps[keyCode]
    if mt ~= nil then
      local modifiers = keysFromFlags(flags)
      if eventType == keyDown then
        mt:press()
      else
        mt:release(modifiers)
      end
      -- Delete the event.
      return true
    end

    -- When any mod-taps are held, intercept and resend.
    if next(self:held()) ~= nil then
      -- Convert flags to a table of modifier key codes.
      local modifiers = keyCodesFromFlags(flags)
      if eventType == keyDown then
        self:sendKeyDown(keyCode, modifiers)
      else
        self:sendKeyUp(keyCode, modifiers)
      end
      -- Delete the event.
      return true
    end

    -- Allow all other key events to propagate normally.
    return false
  end)
  self.handler:start()
end

--------------------------------------------------------------------------------

function mergeAndMakeUnique(tbl1, tbl2)
  local result = {}
  local seen = {}
  for _, value in ipairs(tbl1) do
    if not seen[value] then
      table.insert(result, value)
      seen[value] = true
    end
  end
  for _, value in ipairs(tbl2) do
    if not seen[value] then
      table.insert(result, value)
      seen[value] = true
    end
  end
  return result
end

function keysFromFlags(flags)
  local modifiers = {}
  for k, _ in pairs(flags) do
    table.insert(modifiers, k)
  end
  return modifiers
end

function keyCodesFromFlags(flags)
  local modifiers = {}
  for k, _ in pairs(flags) do
    local modCode = keycodes.map[k]
    if modCode then
      table.insert(modifiers, modCode)
    end
  end
  return modifiers
end

function logEvent(keyCode, eventType, flags)
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

function M.init(config)
  config = config or {}

  local modTaps = ModTapSet.new()
  for k, v in pairs(config.keys) do
    modTaps:add(ModTap.new({
      keyCode = keycodes.map[k],
      modCode = keycodes.map[v.hold]
    }))
  end

  modTaps:start()

  M.modTaps = modTaps
  M.log = hs.logger.new('modtap.log', 'debug')
end

return M
