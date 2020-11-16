local config = require('config.app')
local window_service = require('modules.window_service.module_window_service')

local zones_config = config.spawn_objects.zones

local Spawn_Objects_Zone = {}

function Spawn_Objects_Zone:new(config)
    local zone = {
        spawn_angles = config.spawn_angles,
        paddings_x_y = config.paddings_x_y,
        coords = {}
    }
    self.__index = self
    return setmetatable(zone, self)
end

function Spawn_Objects_Zone:_get_coords()
    return self.coords[1], self.coords[2], self.coords[3], self.coords[4]
end

function Spawn_Objects_Zone:get_spawn_angles()
    return self.spawn_angles[1], self.spawn_angles[2]
end

function Spawn_Objects_Zone:get_paddings()
    return self.paddings_x_y[1], self.paddings_x_y[2]
end

function Spawn_Objects_Zone:set_coords()
    local function _set_paddings(coord1, coord2, padding, length)
        return coord1 + length * padding, coord2 - length * padding
    end

    local height, width = window_service:get_sizes()
    local min_x, min_y, max_x, max_y = window_service:get_coords()
    local padding_x, padding_y = self:get_paddings()

    min_x, max_x = _set_paddings(min_x, max_x, padding_x, width)
    min_y, max_y = _set_paddings(min_y, max_y, padding_y, height)

    return { min_x, min_y, max_x, max_y }
end

return Spawn_Objects_Zone
