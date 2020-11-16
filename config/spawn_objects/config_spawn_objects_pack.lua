local pack_config = {
    sizes = { 3, 6 },
    deviation_bounds = { 0.1, 0.2 }
}

function pack_config:get_sizes() return self.sizes[1], self.sizes[2] end

function pack_config:get_deviation_bounds() return self.deviation_bounds[1], self.deviation_bounds[2] end

return pack_config
