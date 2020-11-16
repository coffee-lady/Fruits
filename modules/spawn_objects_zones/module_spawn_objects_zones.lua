local config = require('config.config_app')
local window_service = require('modules.window_service.module_window_service')
local random_service = require('modules.random_service.random_service')

local zones = require('modules.spawn_objects_zones._internal.init_zones')

local obj_config = config.spawn_objects.object
local pack_config = config.spawn_objects.pack
local random = random_service.random
local random_arr = random_service.random_arr

local zones_module = {}

local function set_object_params(obj, angle_bounds, speed_bounds, coords_bounds_min, coords_bounds_max)
    obj.angle = math.rad(random(angle_bounds[1], angle_bounds[2]))
    
    local speed = random(speed_bounds[1], speed_bounds[2])
    local speed_x = speed * math.cos(obj.angle)
    local speed_y = speed * math.sin(obj.angle)
    obj.speed = vmath.vector3(speed_x, speed_y, 0)

    obj.pos.x = random(coords_bounds_min.x, coords_bounds_max.x)
    obj.pos.y = random(coords_bounds_min.y, coords_bounds_max.y)
end

function zones_module.random_push_obj(obj)
    local zone = zones[math.random(#zones)]
    local coords_start, coords_end = zone:get_coords()

    if not obj then return end

    set_object_params(obj, zone.spawn_angles, obj_config.speed_bounds, coords_start, coords_end)
end

function zones_module.random_push_pack(pack)
    local zone = zones[math.random(#zones)]
    local coords_start, coords_end = zone:get_coords()
    local width, height = window_service:get_sizes()

    local min_speed, max_speed = obj_config:get_speed_bounds()

    local timer = 0
    for i = 1, #pack do
        local obj = pack[i]

        set_object_params(obj, zone.spawn_angles, obj_config.speed_bounds, coords_start, coords_end)

        obj.timer = random_arr(pack_config.timer_bounds) + timer
        timer = timer + obj.timer
    end

    pack.timer = timer
end

return zones_module
