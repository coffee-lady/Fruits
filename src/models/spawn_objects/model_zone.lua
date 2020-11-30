local App = require('src.app')

local Libs = App.libs

local CoordsLib = Libs.coords

local ZoneModel = {}

function ZoneModel:new(angle_bounds, rel_coords_start, rel_coords_end, weight)
    local zone = {
        angle_bounds = angle_bounds,
        rel_coords_start = rel_coords_start,
        rel_coords_end = rel_coords_end,
        weight = weight,
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

    coords_start.x = CoordsLib:set_padd_start(self.rel_coords_start.x, min_coords.x, max_coords.x)
    coords_start.y = CoordsLib:set_padd_start(self.rel_coords_start.y, min_coords.y, max_coords.y)

    return coords_start
end

function ZoneModel:get_coords_end(screen_coords)
    local coords_end = vmath.vector3(0, 0, 0)
    local min_coords, max_coords = screen_coords[1], screen_coords[2]

    coords_end.x = CoordsLib:set_padd_end(self.rel_coords_end.x, min_coords.x, max_coords.x)
    coords_end.y = CoordsLib:set_padd_end(self.rel_coords_end.y, min_coords.y, max_coords.y)

    return coords_end
end

return ZoneModel
