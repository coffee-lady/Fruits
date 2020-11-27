local Libs = require('src.libs.libs')
local Config = require('src.config.config')
local Constants = require('src.constants.constants')

local SpawnObjConstants = Constants.spawn_obj
local Msg = Constants.messages

local ObjectConfig = Config.spawn_objects.object
local PackConfig = Config.spawn_objects.pack
local RandomLib = Libs.random

local random = RandomLib.random
local random_arr = RandomLib.random_arr
local random_with_weights = RandomLib.random_with_weights

local ObjectModel = {}

function ObjectModel:new()
	local random_object = random_with_weights(SpawnObjConstants)

	local obj = {
		pos = vmath.vector3(0, 0, 0),
		class_id = random_object.class_id,
		sprite = random_object.sprite,
		is_bomb = random_object.is_bomb,
		particles_color = random_object.particles_color,
	}

    self.__index = self
    return setmetatable(obj, self)
end

function ObjectModel:spawn(factory_id)
	local msg_text = Msg.spawned_object.set_play_anim

	self.id = factory.create(factory_id, self.pos, nil, nil, self.scale)
	msg.post(msg.url(self.id), msg_text, { data = self })
end

function ObjectModel:set_props(zone, coords_start, coords_end)
	self.timer = random_arr(PackConfig.objects_timer_bounds)
	self.angle = math.rad(random_arr(zone.angle_bounds))

	self.pos.x = random(coords_start.x, coords_end.x)
    self.pos.y = random(coords_start.y, coords_end.y)

	local speed_x = random_arr(ObjectConfig.speed_bounds.x) * math.cos(self.angle)
	local speed_y = random_arr(ObjectConfig.speed_bounds.y) * math.sin(self.angle)

	self.speed = vmath.vector3(speed_x, speed_y, 0)
	self.scale = random_arr(ObjectConfig.scale_bounds)
end

return ObjectModel
