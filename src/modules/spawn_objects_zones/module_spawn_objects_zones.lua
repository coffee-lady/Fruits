local config = require('src.config.config_app')
local window_service = require('src.modules.window_service.module_window_service')
local random_service = require('src.modules.random_service.random_service')

local obj_config = config.spawn_objects.object
local pack_config = config.spawn_objects.pack
local random = random_service.random
local random_arr = random_service.random_arr

local zones_module = {}

local function set_object_params(zone, obj, angle_bounds, speed_bounds, coords_bounds_min, coords_bounds_max)
    obj.angle = math.rad(random(angle_bounds[1], angle_bounds[2]))
    
    local speed_x = random_arr(speed_bounds.x) * math.cos(obj.angle)
    local speed_y = random_arr(speed_bounds.y) * math.sin(obj.angle)

    obj.speed = vmath.vector3(speed_x, speed_y, 0)
    obj.pos.x = random(zone.coords_start.x, zone.coords_end.x)
    obj.pos.y = random(zone.coords_start.y, zone.coords_end.y)
end

function zones_module.set_pack_objects_prop(zones, pack)
    local zone = zones[math.random(#zones)]
    local coords_start, coords_end = zone:get_coords()

    local timer = 0
    for i = 1, #pack do
        local obj = pack[i]

        set_object_params(zone, obj, zone.spawn_angles, obj_config.speed_bounds, coords_start, coords_end)

        obj.timer = random_arr(pack_config.timer_bounds) + timer
        timer = timer + obj.timer
    end

    pack.timer = timer
end

return zones_module
