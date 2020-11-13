local rendercam = require('rendercam.rendercam')

local factory_config = {
    interval = 0.5,
    gravity = 200
}

function factory_config:get_spawn_angles()
    return min_spawn_angle, max_spawn_angle
end

return factory_config
