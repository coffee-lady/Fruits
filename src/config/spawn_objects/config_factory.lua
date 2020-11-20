local FactoryConfig = {
    interval_bounds = { 0.2, 0.3 },
    gravity = 10.5,
}

function FactoryConfig:get_interval_bounds() return self.interval_bounds[1], self.interval_bounds[2] end

return FactoryConfig
