local obj_config = {
    sprites_number = 9,

    speed_bounds = { 600, 750 },

    scale_bounds = { 0.5, 0.7 },
    d_scale_bounds = { 0.05, 0.2 },
    scale_duration_bounds = { 2, 6 },

    rotation_angle = 0.2,
    rotation_duration_bounds = { 2, 6 },
}

function obj_config:get_speed_bounds() return self.speed_bounds[1], self.speed_bounds[2] end

return obj_config
