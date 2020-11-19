local config = require('src.config.config_app')
local ZonesService = require('src.services.spawn_objects_zones.module_spawn_objects_zones')

local Spawn_Objects_Zone = require('src.models.model_spawn_objects_zone')
local zones_config = config.spawn_objects.zones

local ZonesLib = {}

function ZonesLib:init()
    ZonesService:init()
end

function ZonesLib:create_zone(config)
    return Spawn_Objects_Zone:new(config.spawn_angles, config.paddings, config.rel_coords_start, config.rel_coords_end)
end

function ZonesLib:create_zones()
    local zones = {}

    for i = 1, #zones_config.zones do
        zones[#zones + 1] = self:create_zone(zones_config.zones[i])
    end

    return zones
end

return ZonesLib
