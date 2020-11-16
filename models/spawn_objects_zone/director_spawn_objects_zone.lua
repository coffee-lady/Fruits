local config = require('config.app')
local Spawn_Objects_Zone = require('models.spawn_objects_zone.model_spawn_objects_zone')

local Director_Spawn_Objects_Zone = {}

function Director_Spawn_Objects_Zone:build(config, get_coords)
    local zone = Spawn_Objects_Zone:new(config)
    zone.coords = zone:set_coords()
    zone.get_coords = get_coords
    return zone
end

return Director_Spawn_Objects_Zone
