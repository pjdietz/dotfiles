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
