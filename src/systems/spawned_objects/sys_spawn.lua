local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')
local Models = require('src.models.models')

local ObjectModel = Models.spawn_objects.object
local PackModel = Models.spawn_objects.pack
local ObjectsManagerModel = Models.spawn_objects.objects_manager
local ZoneModel = Models.spawn_objects.zone

local MsgConst = Constants.messages
local factory_id = Constants.component_urls.spawn_factory

local ZonesConfig = Config.spawn_objects.zones

local SpawnSystem = {}

local function create_zone(config)
    return ZoneModel:new(config.spawn_angles, config.rel_coords_start, config.rel_coords_end)
end

function SpawnSystem:init()
    self.objects = {}
    self.zones = {}
    self.timer = 0

    for i = 1, #ZonesConfig.zones do
        self.zones[#self.zones + 1] = create_zone(ZonesConfig.zones[i])
    end
end

function SpawnSystem:update(screen_coords, dt, on_deleted_obj_callback)
    ObjectsManagerModel:update_positions(self.objects, factory_id, screen_coords[1], screen_coords[2], dt)

    ObjectsManagerModel:delete_departed_objects(self.objects, screen_coords[1], on_deleted_obj_callback)

	self.timer = self.timer - dt
    if self.timer <= 0 then
        self.timer = PackModel:create(self.objects, self.zones, factory_id, screen_coords)
    end
end

function SpawnSystem:on_deleted_departed_objects(callback)
    ObjectsManagerModel:on_deleted_departed_objects(callback)
end

function SpawnSystem:on_message(message_id, message, sender)
    if message_id == hash(MsgConst.spawned_object.delete_swiped) then
        ObjectsManagerModel:delete(message.id, self.objects)
	end
end

return SpawnSystem
