local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local ObjectModel = require('src.models.spawn_objects.model_object')

local FactoryConfig = Config.spawn_objects.factory
local PackConfig = Config.spawn_objects.pack

local RandomLib = Libs.random

local min_pack, max_pack = PackConfig:get_sizes()

local PackModel = {}

function PackModel:create(objects, zones, factory_id, screen_coords)
	local pack_size = math.random(min_pack, max_pack)
	local zone = zones[math.random(#zones)]
	local start_coords = zone:get_coords_start(screen_coords)
	local end_coords = zone:get_coords_end(screen_coords)
    local pack = {}

	pack.timer = RandomLib.random_arr(FactoryConfig.interval_bounds)

	for i = 1, pack_size do
		local obj = ObjectModel:new()
		obj:set_props(zone, start_coords, end_coords)
		objects[#objects + 1] = obj
	end

	return pack.timer + RandomLib.random_arr(FactoryConfig.interval_bounds)
end

return PackModel
