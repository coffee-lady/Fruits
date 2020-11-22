local PackConfig = {
    sizes = { 3, 6 },
    timer_bounds = { 1, 3 }
}

function PackConfig:get_sizes() return self.sizes[1], self.sizes[2] end

function PackConfig:get_deviation_bounds() return self.deviation_bounds[1], self.deviation_bounds[2] end

return PackConfig
