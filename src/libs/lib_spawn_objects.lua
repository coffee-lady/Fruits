local config = require('src.config.config_app')
local WindowService = require('src.services.window_service.module_window_service')
local zones_module = require('src.services.spawn_objects_zones.module_spawn_objects_zones')
local random_service = require('src.services.random_service.random_service')

local object_config = config.spawn_objects.object
local factory_config = config.spawn_objects.factory
local zones_config = config.spawn_objects.zones
local pack_config = config.spawn_objects.pack

local random = random_service.random
local random_arr = random_service.random_arr

local min_pack, max_pack = pack_config:get_sizes()
local start_coords, end_coords

local SpawnObjectsLib = {
    timer = nil,
    objects = {},
}

function SpawnObjectsLib:init()
	WindowService:update()
	start_coords, end_coords = WindowService:get_coords()
end

function SpawnObjectsLib:create_pack(zones, factory_id)
	local pack_size = random(min_pack, max_pack)

	local pack = {}
	for i = 1, pack_size do
		local obj = {}
		obj.pos = vmath.vector3()
		pack[#pack + 1] = obj
	end

	zones_module:set_pack_objects_prop(zones, pack)

	for i = 1, #pack do
		local obj = pack[i]
		self:set_object_params(obj)

		self.objects[#self.objects + 1] = obj
	end

	local timer_next = pack.timer + random_arr(factory_config.interval_bounds)
	return timer_next
end

function SpawnObjectsLib:set_object_params(obj)
	local speed_x = random_arr(object_config.speed_bounds.x) * math.cos(obj.angle)
	local speed_y = random_arr(object_config.speed_bounds.y) * math.sin(obj.angle)

	obj.speed = vmath.vector3(speed_x, speed_y, 0)
	obj.scale = random_arr(object_config.scale_bounds)
end

function SpawnObjectsLib:set_pack_timer(pack, callback)
	local delay = pack.timer + random_arr(factory_config.interval_bounds)
	timer.delay(delay, false, callback())
end

function SpawnObjectsLib:update_positions(factory_id, dt)
	for i = 1, #self.objects do
		local obj = self.objects[i]
		obj.timer = obj.timer - dt
		if obj.id then
			if obj.pos.y >= end_coords.y - end_coords.y * zones_config.top_padding then
				obj.speed.y = - factory_config.gravity
			end

			obj.speed.y = obj.speed.y - factory_config.gravity
			obj.pos.x = obj.pos.x + obj.speed.x * dt
			obj.pos.y = obj.pos.y + obj.speed.y * dt

			go.set_position(obj.pos, obj.id)

		elseif obj.timer <= 0 then
			obj.id = factory.create(factory_id, obj.pos, nil, nil, obj.scale)
		end
	end

	for i = 1, #self.objects do
		local obj = self.objects[i]

		if obj and obj.pos.y < start_coords.y then
			self:delete_object(obj.id)
		end
	end
end

function SpawnObjectsLib:delete_object(id)
	for i = 1, #self.objects do
		local obj = self.objects[i]

		if obj and obj.id == id then
			go.delete(id)
			table.remove(self.objects, i)
		end
	end
end

function SpawnObjectsLib:animate_scale()
	local scale = go.get('#sprite', 'scale')
	scale = scale - random_arr(object_config.d_scale_bounds) * scale
	go.animate(go.get_id(), 'scale', go.PLAYBACK_ONCE_FORWARD, scale, go.EASING_LINEAR, random_arr(object_config.scale_duration_bounds))
end

function SpawnObjectsLib:animate_rotation()
	local rotation_angle = math.random() >= 0.5 and 360 or -360
	go.animate(go.get_id(), 'euler.z', go.PLAYBACK_LOOP_FORWARD, rotation_angle, go.EASING_LINEAR, random_arr(object_config.rotation_duration_bounds))
end

return SpawnObjectsLib
