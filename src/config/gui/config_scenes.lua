local GuiScenesConfig = {}

GuiScenesConfig.start = {
    transition = {
        duration = 0.3,
        delay = 0,
    },
    button_animation = {
        duration = 0.3,
        blackout = 0.12,
        scale = vmath.vector3(0.1, 0.05, 0),
    },
}

GuiScenesConfig.game = {
    transition = {
        duration = 0.3,
        delay = 0,
    },
    score_animation = {
        label = {
            scale = vmath.vector3(1.2, 1.2, 0, 0),
            duration = 0.3
        },
        label_above_obj = {
            duration = 1,
            rotation_bounds = { -40, 40 },
            color = vmath.vector4(0, 0, 0, 0),
            scale = vmath.vector3(1.3, 1.3, 0, 0),
        },
    },
    button_animation = {
        duration = 0.3,
        blackout = 0.12,
        scale = vmath.vector3(0.1, 0.05, 0),
    },
}

return GuiScenesConfig
