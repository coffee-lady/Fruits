local factory_config = {
    interval_bounds = { 2, 4 },
    gravity = 9,
}

function factory_config:get_interval_bounds() return self.interval_bounds[1], self.interval_bounds[2] end

return factory_config
