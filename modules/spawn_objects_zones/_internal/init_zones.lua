local Director_Zone = require('models.spawn_objects_zone.director_spawn_objects_zone')
local zones_config = require('config.app').spawn_objects.zones

local function left_zone_get_coords(self)
    local min_x, min_y, max_x, max_y = self:_get_coords()

    return min_x, min_y, min_x, max_y
end

local function center_zone_get_coords(self)
    local min_x, min_y, max_x, max_y = self:_get_coords()

    return min_x, min_y, max_x, min_y
end

local function right_zone_get_coords(self)
    local min_x, min_y, max_x, max_y = self:_get_coords()

    return max_x, min_y, max_x, max_y
end

local Left_Zone = Director_Zone:build(zones_config.left_zone, left_zone_get_coords)
local Center_Zone = Director_Zone:build(zones_config.center_zone, center_zone_get_coords)
local Right_Zone = Director_Zone:build(zones_config.right_zone, right_zone_get_coords)

return { Left_Zone, Center_Zone, Right_Zone }
