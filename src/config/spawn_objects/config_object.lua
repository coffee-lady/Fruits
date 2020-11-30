local ObjectConfig = {
    collision_object_radius = 50,

    speed_bounds = {
        x = { 700, 850 },
        y = { 650, 700 },
    },

    bonus_life_speed_bounds = {
        x = { 900, 950 },
        y = { 800, 850 },
    },

    scale_bounds = { 0.7, 1 },
    d_scale_bounds = { 0.1, 0.3 },
    scale_duration_bounds = { 3, 6 },

    rotation_angle = 0.2,
    rotation_duration_bounds = { 3, 6 },

    score_bounds = { 100, 300 },
}

return ObjectConfig
