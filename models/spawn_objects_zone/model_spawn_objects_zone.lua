local config = require('config.config_app')
local window_service = require('modules.window_service.module_window_service')

local zones_config = config.spawn_objects.zones

local Spawn_Objects_Zone = {}

function Spawn_Objects_Zone:new(spawn_angles, paddings, rel_coords_start, rel_coords_end)
    local zone = {
        spawn_angles = spawn_angles,
        _rel_coords_start = rel_coords_start,
        _rel_coords_end = rel_coords_end,
        coords_start = self:_set_coords_start(rel_coords_start),
        coords_end = self:_set_coords_end(rel_coords_end),
    }
    self.__index = self
    return setmetatable(zone, self)
end

function Spawn_Objects_Zone:get_coords()
    return self.coords_start, self.coords_end
end

function Spawn_Objects_Zone:get_spawn_angles()
    return self.spawn_angles[1], self.spawn_angles[2]
end

function Spawn_Objects_Zone:_set_coords_start(_rel_coords_start)
    local height, width = window_service:get_sizes()
    local min_x, min_y, max_x, max_y = window_service:get_coords()

    local coords_start = vmath.vector3(0, 0, 0)
    coords_start.x = vmath.lerp(_rel_coords_start.x, min_x, max_x)
    coords_start.y = vmath.lerp(_rel_coords_start.y, min_y, max_y)

    return coords_start
end

function Spawn_Objects_Zone:_set_coords_end(_rel_coords_end)
    local height, width = window_service:get_sizes()
    local min_x, min_y, max_x, max_y = window_service:get_coords()

    local coords_end = vmath.vector3(0, 0, 0)
    coords_end.x = max_x - ( max_x - min_x ) * _rel_coords_end.x
    coords_end.y = max_y - ( max_y - min_y ) * _rel_coords_end.y

    return coords_end
end

return Spawn_Objects_Zone
