local config = require('config.config_app')
local Spawn_Objects_Zone = require('models.spawn_objects_zone.model_spawn_objects_zone')

local Director_Spawn_Objects_Zone = {}

function Director_Spawn_Objects_Zone:build(config, set_coords)
    local zone = Spawn_Objects_Zone:new(config)
    zone:_set_coords_paddings()
    set_coords(zone)
    return zone
end

return Director_Spawn_Objects_Zone
