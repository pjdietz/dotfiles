local colors = require("colors")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.50,
    cm       = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty --font-size=14"
local fileManager = "thunar"
local menu        = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("~/bin/random-wallpaper")
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets,ssh")
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")
    hl.exec_cmd("dunst &")
    hl.exec_cmd("waybar &")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user restart dropbox.service")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "catppuccin-mocha-mauve-standard+default")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 10,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {colors.sapphire, colors.green}, angle = 45 },
            inactive_border = colors.surface0,
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    group = {
        insert_after_current = true,

        col = {
            border_active   = 0xee33ccff,
            border_inactive = 0xaa595959,
        },

        groupbar = {
            enabled          = true,
            indicator_height = 2,
            render_titles    = false,
            font_size        = 14,
            height           = 20,
            text_color       = 0xffffffff,
            col = {
                active   = 0xee33ccff,
                inactive = 0xaa595959,
            },
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_rate  = 50,
        repeat_delay = 200,

        accel_profile = "adaptive",
        sensitivity   = -0.6,
        scroll_factor = 0.8,
        follow_mouse  = 1,
        mouse_refocus = false,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    animations = {
        enabled = true,
    },
})

-------------------
---- ANIMATIONS ---
-------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local navMod  = "CTRL + SUPER"
local swapMod = "ALT + SUPER"

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

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "steam",
    match = {
        class = "^(steam)$",
        title = "^()$",
    },
    stay_focused = true,
    min_size     = { 1, 1 },
})

hl.window_rule({
    name  = "steam_games",
    match = { class = "^(steam_app_\\d+)$" },
    float            = true,
    size             = { "100%", "100%" },
    center           = true,
    stay_focused     = true,
    border_size      = 0,
    fullscreen_state = "0 2",
    rounding         = 0,
})

hl.window_rule({
    name  = "gamescope",
    match = { class = "^(gamescope)$" },
    float            = true,
    size             = { "100%", "100%" },
    center           = true,
    stay_focused     = true,
    border_size      = 0,
    fullscreen_state = "0 2",
    rounding         = 0,
})
