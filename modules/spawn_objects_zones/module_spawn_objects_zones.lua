local config = require('config.app')
local zones = require('modules.spawn_objects_zones._internal.init_zones')
local window_service = require('modules.window_service.module_window_service')

local obj_config = config.spawn_objects.object
local pack_config = config.spawn_objects.pack

local zones_module = {}

math.randomseed(os.time())

function zones_module.random_push(obj)
    local zone = zones[math.random(#zones)]
    local min_x, min_y, max_x, max_y = zone:get_coords()
    local min_spawn_angle, max_spawn_angle = zone:get_spawn_angles()

    if not obj then return end

    obj.angle = math.random() * (max_spawn_angle - min_spawn_angle) + min_spawn_angle
    obj.speed_x = obj_config.speed * math.cos(obj.angle * math.pi / 180)
    obj.speed_y = obj_config.speed * math.sin(obj.angle * math.pi / 180)
    obj.pos.x = vmath.lerp(math.random(), min_x, max_x)
    obj.pos.y = vmath.lerp(math.random(), min_y, max_y)
end

function zones_module.random_push_pack(pack)
    local zone = zones[math.random(#zones)]
    local min_x, min_y, max_x, max_y = zone:get_coords()
    local min_spawn_angle, max_spawn_angle = zone:get_spawn_angles()
    local width, height = window_service:get_sizes()

    if not pack then return end

    local pos_x = vmath.lerp(math.random(), min_x, max_x)
    local pos_y = vmath.lerp(math.random(), min_y, max_y)

    local min_deviation, max_deviation = pack_config:get_deviation_bounds()
    local deviation = math.random() * ( max_deviation - min_deviation ) + min_deviation
    deviation = math.random() >= 0.5 and deviation or -deviation

    for i = 1, #pack do
        local obj = pack[i]

        local min_speed, max_speed = obj_config:get_speed_bounds()

        local speed_x = math.random() * ( max_speed - min_speed ) + min_speed
        local speed_y = math.random() * ( max_speed - min_speed ) + min_speed

        obj.angle = math.random() * (max_spawn_angle - min_spawn_angle) + min_spawn_angle
        obj.speed_x = speed_x * math.cos(obj.angle * math.pi / 180)
        obj.speed_y = speed_y * math.sin(obj.angle * math.pi / 180)
        obj.pos.x = pos_x ~= min_x and pos_x + width * deviation or pos_x
        obj.pos.y = pos_y ~= min_y and pos_y + height * deviation or pos_y
    end
end

return zones_module
