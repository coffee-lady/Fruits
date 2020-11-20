local config = require('src.config.config_app')
local WindowService = require('src.services.window_service.module_window_service')
local random_service = require('src.services.random_service.random_service')

local obj_config = config.spawn_objects.object
local PackConfig = config.spawn_objects.pack
local random = random_service.random
local random_arr = random_service.random_arr

local min_coords, max_coords

local ZonesService = {}

local function set_object_params(zone, obj, angle_bounds, coords_start, coords_end)
    obj.angle = math.rad(random(angle_bounds[1], angle_bounds[2]))
    
    obj.pos.x = random(coords_start.x, coords_end.x)
    obj.pos.y = random(coords_start.y, coords_end.y)
end

local function set_coords_start(_rel_coords_start, min_coords, max_coords)
    local coords_start = vmath.vector3(0, 0, 0)
    coords_start.x = vmath.lerp(_rel_coords_start.x, min_coords.x, max_coords.x)
    coords_start.y = vmath.lerp(_rel_coords_start.y, min_coords.y, max_coords.y)

    return coords_start
end

local function set_coords_end(_rel_coords_end, min_coords, max_coords)
    local coords_end = vmath.vector3(0, 0, 0)
    coords_end.x = max_coords.x - ( max_coords.x - min_coords.x ) * _rel_coords_end.x
    coords_end.y = max_coords.y - ( max_coords.y - min_coords.y ) * _rel_coords_end.y

    return coords_end
end

function ZonesService:init()
    WindowService:update()
    min_coords, max_coords = WindowService:get_coords()
end

function ZonesService:set_pack_objects_prop(zones, pack)
    local zone = zones[math.random(#zones)]
    local rel_coords_start, rel_coords_end = zone:get_rel_coords()

    local coords_start = set_coords_start(rel_coords_start, min_coords, max_coords)
    local coords_end = set_coords_end(rel_coords_end, min_coords, max_coords)

    local timer = 0
    for i = 1, #pack do
        local obj = pack[i]

        set_object_params(zone, obj, zone.spawn_angles, coords_start, coords_end)

        obj.timer = random_arr(PackConfig.timer_bounds) + timer
        timer = timer + obj.timer
    end

    pack.timer = timer
end

return ZonesService
