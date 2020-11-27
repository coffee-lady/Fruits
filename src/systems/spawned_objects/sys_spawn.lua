local Config = require('src.config.config')
local Constants = require('src.constants.constants')
local Models = require('src.models.models')

local PackModel = Models.spawn_objects.pack
local ObjectsManagerModel = Models.spawn_objects.objects_manager
local ZoneModel = Models.spawn_objects.zone

local MsgConst = Constants.messages
local factory_id = Constants.component_urls.scenes.game.factory

local ZonesConfig = Config.spawn_objects.zones

local SpawnSystem = {}

local function create_zone(config)
    return ZoneModel:new(config.spawn_angles, config.rel_coords_start, config.rel_coords_end, config.weight)
end

function SpawnSystem:init()
    self.objects = {}
    self.zones = {}
    self.timer = 0
    self.game_over = false

    for i = 1, #ZonesConfig.zones do
        self.zones[#self.zones + 1] = create_zone(ZonesConfig.zones[i])
    end
end

function SpawnSystem:update(screen_coords, dt)
    ObjectsManagerModel:update_positions(self.objects, factory_id, screen_coords[1], screen_coords[2], dt)

    ObjectsManagerModel:delete_departed_objects(self.objects, screen_coords[1])

	self.timer = self.timer - dt
    if self.timer <= 0 and not self.game_over then
        self.timer = PackModel:create(self.objects, self.zones, screen_coords)
    end
end

function SpawnSystem:wait_for_objects(callback)
	timer.delay(0, true, function (_, handle)
        if #self.objects == 0 then
            timer.cancel(handle)
            callback()
        end
    end)
end

function SpawnSystem:on_game_over(callback)
    self.game_over = true
    self:wait_for_objects(callback)
end

function SpawnSystem:on_deleted_departed_object(callback)
    ObjectsManagerModel:on_deleted_departed_object(callback)
end

function SpawnSystem:on_message(message_id, message, sender)
    if message_id == hash(MsgConst.spawned_object.delete_swiped) then
        if self.game_over then return end
        ObjectsManagerModel:delete(message.id, self.objects)
	end
end

return SpawnSystem
