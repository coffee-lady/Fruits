local window_module = require('spawn_objects.modules.window')
local zones_config = require('spawn_objects.config.zones')
local obj_config = require('spawn_objects.config.object')

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

local Left_Zone = Zone:new(zones_config.left_zone)
local Center_Zone = Zone:new(zones_config.center_zone)
local Right_Zone = Zone:new(zones_config.right_zone)

local function set_padding(coord, padding)
    return coord - coord * padding
end

function Left_Zone:get_coords()
    local min_x, min_y, max_x, max_y = window_module.get_coords()
    local padding_x, padding_y = Center_Zone:get_paddings()

    min_x = set_padding(min_x, padding_x)
    max_y = set_padding(max_y, padding_y)
    min_y = set_padding(min_y, padding_y)

    return min_x, min_y, min_x, max_y
end

function Center_Zone:get_coords()
    local min_x, min_y, max_x, max_y = window_module.get_coords()
    local padding_x, padding_y = Left_Zone:get_paddings()

    min_x = set_padding(min_x, padding_x)
    max_x = set_padding(max_x, padding_x)
    min_y = set_padding(min_y, padding_y)

    return min_x, min_y, max_x, min_y
end

function Right_Zone:get_coords()
    local min_x, min_y, max_x, max_y = window_module.get_coords()
    local padding_x, padding_y = Right_Zone:get_paddings()

    max_x = set_padding(max_x, padding_x)
    max_y = set_padding(max_y, padding_y)
    min_y = set_padding(min_y, padding_y)

    return max_x, min_y, max_x, max_y
end

local zones = { Left_Zone, Center_Zone, Right_Zone }

function zones.random_push(obj)
    math.randomseed(os.time() / math.random())
    local zone = zones[math.random(1, 3)]
    local min_x, min_y, max_x, max_y = zone.get_coords()
    local min_spawn_angle, max_spawn_angle = zone:get_spawn_angles()

    if not obj then return end
    obj.angle = math.random() * (max_spawn_angle - min_spawn_angle) + min_spawn_angle

    obj.speed_x = obj_config.speed * math.cos(obj.angle)
    obj.speed_y = obj_config.speed * math.sin(obj.angle)
    obj.pos.x = math.random() * (max_x - min_x) + min_x
    obj.pos.y = math.random() * (max_y - min_y) + min_y
end

return zones
