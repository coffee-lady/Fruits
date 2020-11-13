local window_module = require('spawn_objects.modules.window')

local zones_config = {
    center_zone = {
        spawn_angles = { math.pi / 4, math.pi * 3 / 4 },
        paddings_x_y = { 0.3, 0 },
    },
    left_zone = {
        spawn_angles = { math.pi / 6, math.pi / 3 },
        paddings_x_y = { 0, 0.4 },
    },
    right_zone = {
        spawn_angles = { math.pi * 2 / 3, math.pi * 5 / 6 },
        paddings_x_y = { 0, 0.4 },
    },
}

return zones_config
