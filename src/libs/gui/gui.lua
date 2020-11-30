local GuiLib = {}

local function set_non_negative(prop, blackout)
    return prop - blackout > 0 and prop - blackout or 0
end

function GuiLib:animate_button_click(button, blackout, delta_scale, duration)
    local color = gui.get_color(button)
    local scale = gui.get_scale(button)

    scale.x = scale.x - delta_scale.x * scale.x
    scale.y = scale.y - delta_scale.y * scale.y

    color.x = set_non_negative(color.x, blackout)
    color.y = set_non_negative(color.y, blackout)
    color.z = set_non_negative(color.z, blackout)

    gui.animate(button, gui.PROP_COLOR, color, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_PINGPONG)
    gui.animate(button, gui.PROP_SCALE, scale, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_PINGPONG)
end

return GuiLib
