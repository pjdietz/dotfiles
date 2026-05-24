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
