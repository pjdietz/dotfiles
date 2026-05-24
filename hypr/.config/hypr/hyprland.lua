colors = require("colors")

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

terminal    = "ghostty --font-size=14"
fileManager = "thunar"
menu        = "rofi -show drun"

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

---------------------
---- KEYBIND MODS ---
---------------------

mainMod = "SUPER"
navMod  = "CTRL + SUPER"
swapMod = "ALT + SUPER"

-----------------
---- MODULES ----
-----------------

require("settings")
require("animations")
require("keybinds")
require("rules")
