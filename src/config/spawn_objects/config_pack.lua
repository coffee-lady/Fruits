local PackConfig = {
    sizes = { 3, 6 },
    timer_bounds = { 1, 3 }
}

function PackConfig:get_sizes() return self.sizes[1], self.sizes[2] end


return PackConfig
