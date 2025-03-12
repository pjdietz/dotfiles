local M = {}

local eventtap = require("hs.eventtap")


local keyDown = eventtap.event.types.keyDown
local keyUp = eventtap.event.types.keyUp
local flagsChanged = eventtap.event.types.flagsChanged

local log = hs.logger.new('MyLogger', 'debug')

local modCtrl = false

local modTap = {
  key = "z",
  lastDown = 0,
}


local fakeCtrl = false
local sending = false

function M.setup(config)
  config = config or {}

  local e = eventtap.new({keyDown, keyUp, flagsChanged}, function (event)

    if sending then
      log.d("key event while sending, skip.")
      return true
    end

    log.d("key event")

    local keyCode = event:getKeyCode()
    local eventType = event:getType()
    local currentTime = hs.timer.secondsSinceEpoch()

    local modifier = hs.keycodes.map.ctrl

    if keyCode == hs.keycodes.map.ctrl then
      log.d("found ctrl")
    end

    if keyCode == hs.keycodes.map["space"] then
      log.d("Space")
      if fakeCtrl then
        log.d("Fake Ctrl")
        if eventType == keyDown then
          log.d("Fake Ctrl Down")
          sending = true
          hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
          hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, true):post()
          sending = false
          return true
        elseif eventType == keyUp then
          log.d("Fake Ctrl Up")
          sending = true
          hs.eventtap.event.newKeyEvent(hs.keycodes.map.space, false):post()
          hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
          sending = false
          return true
        else
          log.d("Fake Ctrl Flags")
        end
      end
      return false
    end

    if keyCode == hs.keycodes.map["z"] then
      log.d("z")

      if eventType == keyDown then

        -- Ignore additional down events.
        if modTap.timer then
        -- if modTap.lastDown > 0 then
          log.d("z ignore additional down event")
          return true
        end

        modTap.lastDown = currentTime
        modTap.triggered = false

        if modTap.timer then
          modTap.timer:stop()
        end
        modTap.timer = hs.timer.doAfter(0.2, function ()
          log.d("keyDown Ctrl")
          -- hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
          -- hs.eventtap.event.newKeyEvent(modifier, true):post()
          fakeCtrl = true
          modTap.triggered = true
          modTap.timer:stop()
          modTap.timer = nil
        end)

        return true

      elseif eventType == keyUp then
        log.d("up")

        -- Stop the timer
        if modTap.timer then
          modTap.timer:stop()
          modTap.timer = nil
        end

        -- If the modifier wasn't triggered and it was a short press, send Z
        if not modTap.triggered then
            -- Send Z key press and release
            -- hs.eventtap.keyStroke(nil, "z")
            -- hs.eventtap.event.newKeyEvent({}, keyCode, true):post()
            -- hs.eventtap.event.newKeyEvent({}, keyCode, false):post()
            log.d("keyUp Z")
            modTap.lastDown = 0
            modTap.triggered = false
        else
            -- Release Ctrl modifier
            log.d("keyUp Ctrl")
            fakeCtrl = false
            modTap.lastDown = 0
            modTap.triggered = false
        end

        return true





      else
        log.d("changed")
      end


    end

  end)

  e:start()



  hs.alert.show("Keyboard setup")
  return M
end


return M
