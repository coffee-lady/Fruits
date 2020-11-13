local obj_config = require('spawn_objects.config.object')
local zones = require('spawn_objects.modules.zones.classes')

local module = {}
function module.random_push(obj)
    math.randomseed(os.time() / math.random())

    local zone = zones[math.random(1, 3)]
    local min_x, min_y, max_x, max_y = zone:get_coords()
    local min_spawn_angle, max_spawn_angle = zone:get_spawn_angles()

    if not obj then return end
    obj.angle = math.random() * (max_spawn_angle - min_spawn_angle) + min_spawn_angle

    obj.speed_x = obj_config.speed * math.cos(obj.angle)
    obj.speed_y = obj_config.speed * math.sin(obj.angle)
    obj.pos.x = math.random() * (max_x - min_x) + min_x
    obj.pos.y = math.random() * (max_y - min_y) + min_y
end

return module
