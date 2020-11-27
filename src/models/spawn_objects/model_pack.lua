local Libs = require('src.libs.libs')
local Config = require('src.config.config')

local ObjectModel = require('src.models.spawn_objects.model_object')

local PackConfig = Config.spawn_objects.pack

local RandomLib = Libs.random

local min_pack, max_pack = PackConfig:get_sizes()

local PackModel = {}

function PackModel:create(objects, zones, screen_coords)
	local pack_size = math.random(min_pack, max_pack)
	local zone = RandomLib.random_with_weights(zones)
	local start_coords = zone:get_coords_start(screen_coords)
	local end_coords = zone:get_coords_end(screen_coords)
    local pack = {}

	pack.timer = RandomLib.random_arr(PackConfig.packs_interval_bounds)

	local bombs_count = 0

	for i = 1, pack_size do
		local obj = ObjectModel:new()
		if obj.is_bomb then
			if bombs_count == PackConfig.max_bombs then
				while obj.is_bomb do
					obj = ObjectModel:new()
				end
			else
				bombs_count = bombs_count + 1
			end
		end

		obj:set_props(zone, start_coords, end_coords)
		objects[#objects + 1] = obj
	end

	return pack.timer + RandomLib.random_arr(PackConfig.packs_interval_bounds)
end

return PackModel
