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
        scale = 1.2,
        duration = 0.3,
    },
    button_animation = {
        duration = 0.3,
        blackout = 0.12,
        scale = vmath.vector3(0.1, 0.05, 0),
    },
}

return GuiScenesConfig
