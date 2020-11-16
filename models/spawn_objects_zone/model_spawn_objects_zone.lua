local config = require('config.config_app')
local window_service = require('modules.window_service.module_window_service')

local zones_config = config.spawn_objects.zones

local Spawn_Objects_Zone = {}

function Spawn_Objects_Zone:new(config)
    local zone = {
        spawn_angles = config.spawn_angles,
        paddings = config.paddings,
        coords_start = nil,
        coords_end = nil,
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

function Spawn_Objects_Zone:get_paddings()
    return self.paddings_x_y[1], self.paddings_x_y[2]
end

function Spawn_Objects_Zone:_set_coords_paddings()
    local function _set_paddings(coord1, coord2, padding, length)
        return coord1 + length * padding, coord2 - length * padding
    end

    local height, width = window_service:get_sizes()
    local min_x, min_y, max_x, max_y = window_service:get_coords()

    min_x, max_x = _set_paddings(min_x, max_x, self.paddings.x, width / 2)
    min_y, max_y = _set_paddings(min_y, max_y, self.paddings.y, height / 2)

    self.coords_start = vmath.vector3(min_x, min_y, 0)
    self.coords_end = vmath.vector3(max_x, max_y, 0)
end

return Spawn_Objects_Zone
