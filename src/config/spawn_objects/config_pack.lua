local PackConfig = {
    sizes = { 3, 5 },
    packs_interval_bounds = { 1, 2 },
    gravity = 10.5,
    objects_timer_bounds = { 1, 3 },
    max_bombs = 2,
}

function PackConfig:get_sizes() return self.sizes[1], self.sizes[2] end


return PackConfig
