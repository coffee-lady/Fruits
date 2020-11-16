local obj_config = {
    speed_bounds = { 600, 750 },
    sprites_number = 9,
    d_scale = 0.1
}

function obj_config:get_speed_bounds() return self.speed_bounds[1], self.speed_bounds[2] end

return obj_config
