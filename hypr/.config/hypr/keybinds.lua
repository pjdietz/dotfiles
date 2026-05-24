-- Focus
hl.bind(navMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(navMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(navMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(navMod .. " + L", hl.dsp.focus({ direction = "r" }))

-- Swap
hl.bind(swapMod .. " + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(swapMod .. " + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(swapMod .. " + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(swapMod .. " + L", hl.dsp.window.swap({ direction = "r" }))

-- Fullscreen and layout
hl.bind(navMod .. " + F",         hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(navMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(navMod .. " + D",         hl.dsp.layout("togglesplit"))

-- Groups
hl.bind(navMod .. " + G", hl.dsp.group.toggle())
hl.bind(navMod .. " + N", hl.dsp.group.next())
hl.bind(navMod .. " + P", hl.dsp.group.prev())
hl.bind(navMod .. " + X", hl.dsp.window.move({ out_of_group = true }))

hl.bind("CTRL + ALT + H", hl.dsp.window.move({ into_group = "l" }))
hl.bind("CTRL + ALT + J", hl.dsp.window.move({ into_group = "d" }))
hl.bind("CTRL + ALT + K", hl.dsp.window.move({ into_group = "u" }))
hl.bind("CTRL + ALT + L", hl.dsp.window.move({ into_group = "r" }))

-- Power menu and close
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/waybar/power-menu.sh"))
hl.bind(mainMod .. " + W", hl.dsp.window.close())

-- Launch apps
hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Switch workspaces / move windows to workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(navMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(navMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap
hl.bind(navMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("J", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
