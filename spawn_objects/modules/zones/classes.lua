local window_module = require('spawn_objects.modules.window')
local zones_config = require('spawn_objects.config.zones')

local Zone = {}

function Zone:new(config)
    local zone = {
        spawn_angles = config.spawn_angles,
        paddings_x_y = config.paddings_x_y
    }
    self.__index = self
    return setmetatable(zone, self)
end

function Zone:get_spawn_angles()
    return self.spawn_angles[1], self.spawn_angles[2]
end

function Zone:get_paddings()
    return self.paddings_x_y[1], self.paddings_x_y[2]
end

function Zone:set_paddings()
    local function set_paddings(coord1, coord2, padding, length)
        return coord1 + length / 2 * padding, coord2 - length / 2 * padding
    end

    local height, width = window_module.get_sizes()
    local min_x, min_y, max_x, max_y = window_module.get_coords()
    local padding_x, padding_y = self:get_paddings()

    min_x, max_x = set_paddings(min_x, max_x, padding_x, width)
    min_y, max_y = set_paddings(min_y, max_y, padding_y, height)

    return min_x, min_y, max_x, max_y
end

local Left_Zone = Zone:new(zones_config.left_zone)
local Center_Zone = Zone:new(zones_config.center_zone)
local Right_Zone = Zone:new(zones_config.right_zone)

function Left_Zone:get_coords()
    local min_x, min_y, max_x, max_y = self:set_paddings()

    return min_x, min_y, min_x, max_y
end

function Center_Zone:get_coords()
    local min_x, min_y, max_x, max_y = self:set_paddings()

    return min_x, min_y, max_x, min_y
end

function Right_Zone:get_coords()
    local min_x, min_y, max_x, max_y = self:set_paddings()

    return max_x, min_y, max_x, max_y
end

return { Left_Zone, Center_Zone, Right_Zone }
