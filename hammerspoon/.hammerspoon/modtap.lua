local M = {}

local eventtap = require("hs.eventtap")
local keycodes = require("hs.keycodes")

local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp

local flagsToKeyCodes
local flagsToKeys
local keysToKeyCodes
local logEvent
local mergeAndMakeUnique

-- ModTap ----------------------------------------------------------------------

local ModTap = {}
ModTap.__index = ModTap

function ModTap.new(config)
  local m = {
    keyCode = config.keyCode,
    modifiers = config.modifiers,
    threshold = config.threshold or 0.1,
    down = false,
    held = false,
    timer = nil,
    parent = nil,
  }
  return setmetatable(m, ModTap)
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
      for _, m in ipairs(k.modifiers) do
        table.insert(heldModifiers, m)
      end
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
      local modifiers = flagsToKeys(flags)
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
      local modifiers = flagsToKeyCodes(flags)
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

-- Utility ---------------------------------------------------------------------

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

function flagsToKeys(flags)
  local modifiers = {}
  for k, _ in pairs(flags) do
    table.insert(modifiers, k)
  end
  return modifiers
end

function keysToKeyCodes(flags)
  local keyCodes = {}
  for _, k in ipairs(flags) do
    table.insert(keyCodes, k)
  end
  return keyCodes
end

function flagsToKeyCodes(flags)
  return keysToKeyCodes(flagsToKeys(flags))
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

-- Module ----------------------------------------------------------------------

function M.init(config)
  config = config or {}

  local threshold = config.threshold or 0.1

  local modTaps = ModTapSet.new()
  for key, keyOpts in pairs(config.keys) do
    modTaps:add(ModTap.new({
      keyCode = keycodes.map[key],
      modifiers = keysToKeyCodes(keyOpts.hold),
      threshold = keyOpts.threshold or threshold
    }))
  end

  modTaps:start()

  M.modTaps = modTaps
  M.log = hs.logger.new('modtap.log', 'debug')
end

return M
