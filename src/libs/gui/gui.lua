local GuiLib = {}

local function set_non_negative(prop, blackout)
    return prop - blackout > 0 and prop - blackout or 0
end

function GuiLib:animate_button_click_pressed(button, blackout, delta_scale, duration)
    local color = gui.get_color(button)
    local scale = gui.get_scale(button)

    scale.x = scale.x - delta_scale.x * scale.x
    scale.y = scale.y - delta_scale.y * scale.y

    color.x = set_non_negative(color.x, blackout)
    color.y = set_non_negative(color.y, blackout)
    color.z = set_non_negative(color.z, blackout)

    gui.animate(button, gui.PROP_COLOR, color, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_FORWARD)
    gui.animate(button, gui.PROP_SCALE, scale, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_FORWARD)

    self[gui.get_id(button)].is_pressed = true
end

function GuiLib:animate_button_click_released(button, duration)
    local btn_data = self[gui.get_id(button)]
    btn_data.is_pressed = false

    local scale = gui.get_scale(button)
    scale.x = scale.x + btn_data.delta_scale.x * scale.x
    scale.y = scale.y + btn_data.delta_scale.y * scale.y

    gui.animate(button, gui.PROP_COLOR, btn_data.color, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_FORWARD)
    gui.animate(button, gui.PROP_SCALE, scale, gui.EASING_INCUBIC, duration, 0, nil, gui.PLAYBACK_ONCE_FORWARD)
end

function GuiLib:animate_button_click(action, button, blackout, delta_scale, duration)
    local btn_data = self[gui.get_id(button)]

    if not btn_data then
        self[gui.get_id(button)] = {
            is_pressed = false,
            color = gui.get_color(button),
            delta_scale = delta_scale,
        }
        btn_data = self[gui.get_id(button)]
    end

    if gui.pick_node(button, action.x, action.y) and action.pressed and not btn_data.is_pressed then
        self:animate_button_click_pressed(button, blackout, delta_scale, duration)
    end

    if action.released then
        if btn_data.is_pressed then
            self:animate_button_click_released(button, duration)
        end
    end
end

return GuiLib
