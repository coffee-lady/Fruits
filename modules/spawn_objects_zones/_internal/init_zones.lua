local Director_Zone = require('models.spawn_objects_zone.director_spawn_objects_zone')
local zones_config = require('config.config_app').spawn_objects.zones

local function left_zone_set_coords(zone)
    zone.coords_end.x = zone.coords_start.x
end

local function center_zone_set_coords(zone)
    zone.coords_end.y = zone.coords_start.y
end

local function right_zone_set_coords(zone)
    zone.coords_start.x = zone.coords_end.x
end

local Left_Zone = Director_Zone:build(zones_config.left_zone, left_zone_set_coords)
local Center_Zone = Director_Zone:build(zones_config.center_zone, center_zone_set_coords)
local Right_Zone = Director_Zone:build(zones_config.right_zone, right_zone_set_coords)

return { Left_Zone, Center_Zone, Right_Zone }
