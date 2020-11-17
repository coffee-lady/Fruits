local factory_config = {
    interval_bounds = { 0.2, 0.3 },
    gravity = 10.5,
}

function factory_config:get_interval_bounds() return self.interval_bounds[1], self.interval_bounds[2] end

return factory_config
