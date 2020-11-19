local config = require('src.config.config_app')

local zones_config = config.spawn_objects.zones

local Spawn_Objects_Zone = {}

function Spawn_Objects_Zone:new(spawn_angles, paddings, rel_coords_start, rel_coords_end)
    local zone = {
        spawn_angles = spawn_angles,
        _rel_coords_start = rel_coords_start,
        _rel_coords_end = rel_coords_end,
    }
    self.__index = self
    return setmetatable(zone, self)
end

function Spawn_Objects_Zone:get_rel_coords()
    return self._rel_coords_start, self._rel_coords_end
end

function Spawn_Objects_Zone:get_spawn_angles()
    return self.spawn_angles[1], self.spawn_angles[2]
end

return Spawn_Objects_Zone
