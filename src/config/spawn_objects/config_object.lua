local obj_config = {
    sprites_number = 9,
    collision_object_radius = 50,

    speed_bounds = {
        x = { 700, 850 },
        y = { 650, 700 },
    },

    scale_bounds = { 0.5, 0.7 },
    d_scale_bounds = { 0.1, 0.3 },
    scale_duration_bounds = { 3, 6 },

    rotation_angle = 0.2,
    rotation_duration_bounds = { 3, 6 },

    score_bounds = { 100, 200 }
}

function obj_config:get_speed_bounds() return self.speed_bounds[1], self.speed_bounds[2] end

return obj_config
