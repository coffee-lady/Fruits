local config = require('src.config.config')

local zones_config = config.spawn_objects.zones

local ZoneModel = {}

function ZoneModel:new(angle_bounds, rel_coords_start, rel_coords_end)
    local zone = {
        angle_bounds = angle_bounds,
        rel_coords_start = rel_coords_start,
        rel_coords_end = rel_coords_end,
    }
    self.__index = self
    return setmetatable(zone, self)
end

function ZoneModel:get_rel_coords()
    return self.rel_coords_start, self.rel_coords_end
end

function ZoneModel:get_coords_start(screen_coords)
    local coords_start = vmath.vector3(0, 0, 0)
    local min_coords, max_coords = screen_coords[1], screen_coords[2]

    coords_start.x = min_coords.x + self.rel_coords_start.x * (max_coords.x - min_coords.x)
    coords_start.y = min_coords.y + self.rel_coords_start.y * (max_coords.y - min_coords.y)

    return coords_start
end

function ZoneModel:get_coords_end(screen_coords)
    local coords_end = vmath.vector3(0, 0, 0)
    local min_coords, max_coords = screen_coords[1], screen_coords[2]

    coords_end.x = max_coords.x - self.rel_coords_end.x * (max_coords.x - min_coords.x)
    coords_end.y = max_coords.y - self.rel_coords_end.y * (max_coords.y - min_coords.y)

    return coords_end
end

return ZoneModel
